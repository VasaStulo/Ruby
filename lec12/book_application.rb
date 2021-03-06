require 'roda'
require 'forme'
require_relative 'models'
require 'date'

class BookApplication < Roda 
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:books] = BookList.new(
    [
      Book.new(
        id: 25,
        title: 'Матан',
        author: 'Бондаренко',
        published_on: Date.parse('2013-06-18'),
        mark:4,
        circulation: 3.5
      ),
      Book.new(
        id: 2,
        title: 'Си программирование',
        author: 'Васильев',
        published_on: Date.parse('2003-02-08'),
        mark:10,
        circulation: 4.5
      ),
      Book.new(
        id: 200,
        title: 'Комплексный анализ',
        author: 'Ануфриенко',
        published_on: Date.parse('1990-12-12'),
        mark:2,
        circulation: 10
      )
    ]
  )

status_handler(404) do
  view('not_found')
end

  route do |r|
    r.public if opts[:serve_static]

    r.root do 
      r.redirect '/books'
    end
    
    r.on 'books' do
      r.is do 
        @books = opts[:books].all_books
        view('books')
      end

      r.on Integer do |book_id|
        @book = opts[:books].book_by_id(book_id)
        next if @book.nil?

        r.is do
          view('book')
        end

        r.on 'edit' do 
            r.get do
              @parameters = @book.to_h
              view('book_edit')
            end
            r.post do 
              @parameters = DryResultFormeWrapper.new(BookFormSchema.call(r.params))
              if @parameters.success?
                opts[:books].update_book(@book.id, @parameters)
                r.redirect "/books/#{@book.id}"
              else
                view('book_edit')
              end
            end
        end

      r.on 'delete' do 
        r.get do 
          @parameters={}
          view('book_delete')
        end

        r.post do 
          @parameters = DryResultFormeWrapper.new(BookDeleteSchema.call(r.params))
          if @parameters.success?
            opts[:books].delete_book(@book.id)
            r.redirect('/books')
          else
            view('book_delete')
          end
        end
      end
    end
      
      r.on 'new' do
        r.get do
          @parameters ={}
          view('book_new')
        end
        
        r.post do
          @parameters = DryResultFormeWrapper.new(BookFormSchema.call(r.params))
          if @parameters.success?
            book_id = opts[:books].add_book(@parameters)
            r.redirect "/books/#{book_id}"
          else
            view('book_new')
          end
        end
      end
  end
  end 
end