# frozen_string_literal: true

require 'roda'
require 'forme'
require_relative 'models'
# require 'date'

# Main application class
class LibraryApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:books] = BooksList.new

  opts[:readers] = ReadersList.new(opts[:books])

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/library'
    end

    r.on 'library' do
      view('library')
    end

    r.on 'books' do
      r.is do
        @params = DryResultFormeWrapper.new(BookFilterFormSchema.call(r.params))
        @filter_books = if @params.success?
                          opts[:books].filter_books(@params[:genre])
                        else
                          opts[:books].all_books
                        end

        view('books')
      end

      r.on Integer do |book_id|
        @book = opts[:books].book_by_id(book_id)
        next if @book.nil?

        r.is do
          view('book')
        end

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('book_delete')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(BookDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:books].down_recount_book(book_id, opts[:readers])
              opts[:readers].removal_book_from_reader(book_id, opts[:books])
              opts[:books].delete_book(book_id)
              r.redirect('/books')
            else
              view('book_delete')
            end
          end
        end
    end

      r.on 'new' do
        r.get do
          @parameters = {}
          view('new_book')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(BookFormSchema.call(r.params))
          if @parameters.success?
            book_id = opts[:books].add_book(@parameters, opts[:readers])
            opts[:books].book_recount(book_id, @parameters[:number])
            r.redirect "/books/#{book_id}"
          else
            view('new_book')
          end
        end
      end
    end

    r.on 'readers' do
      r.is do
        @readers_list = opts[:readers].all_readers
        view('readers')
      end

      r.on Integer do |reader_id|
        @reader = opts[:readers].reader_by_id(reader_id)
        @list_genre = opts[:books].list_of_genre
        @list_author = opts[:books].list_of_author
        @own_books_list = opts[:readers].own_books_list_by_reader(reader_id)
        next if @reader.nil?

        r.is do
          view('reader')
        end

        r.on 'penalty' do
          r.is do
            # opts[:books].book_return(r.params['book'])
            view('penalty')
          end
        end

        r.on 'book_add' do
          r.get do
            @parameters = {}
            view('add_book_to_reader')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(BookAddFormSchema.call(r.params))
            if @parameters.success?
              opts[:readers].book_add_to_reader(@parameters, reader_id)
              r.redirect "/readers/#{reader_id}"
            else
              view('add_book_to_reader')
            end
          end
        end

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('reader_delete')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(ReaderDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:books].book_recount_after_delete(reader_id, opts[:readers])
              opts[:readers].delete_reader(reader_id)
              r.redirect('/readers')
            else
              view('reader_delete')
            end
          end
        end
      end

      r.on 'new' do
        r.get do
          @parameters = {}
          view('new_reader')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(ReaderFormSchema.call(r.params))
          if @parameters.success?
            reader_id = opts[:readers].add_reader(@parameters)
            r.redirect "/readers/#{reader_id}"
          else
            view('new_reader')
          end
        end
      end
    end
  end
end
