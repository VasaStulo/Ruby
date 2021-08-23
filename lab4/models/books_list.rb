# frozen_string_literal: true

require 'csv'
require_relative 'book'

#  A class for working with book methods
class BooksList
  DATA_BOOKS = File.expand_path('../data/books.csv', __dir__)

  def initialize
    @books_list = []
    read_data_book
  end

  def read_data_book
    return unless File.exist?(DATA_BOOKS)

    id = 0
    CSV.foreach(DATA_BOOKS, headers: false) do |row|
      initials = row[0].split(/(.(.))/)[1] + row[0].split(/(.(.))/)[4]
      surname = row[0].split(//, 5)[4]
      age = row[4].to_i
      book = Book.new(id, initials, surname, row[1], row[2], row[3], age, row[5].to_i, row[6].to_i)
      @books_list[book.id] = book
      id += 1
    end

    @books_list = @books_list.map do |book|
      [book.id, book]
    end.to_h
  end

  def book_by_id(id)
    @books_list[id]
  end

  def id_by_author_and_title(author, title)
    @books_list.each do |_id, book|
      if author == "#{book.initials_author}#{book.author_surname}" && book.title == title
        return book.id
      end
    end
  end

  def all_books
    @books_list.values
  end

  def book_by_invent_number(invent_number)
    @books_list.each do |_id, book|
      return book if book.number == invent_number
    end
    nil
  end

  def get_count_library(number)
    count = 1
    @books_list.each do |_id, book|
      count += 1 if book.number.split('-')[0] == number.split('-')[0]
    end
    count
  end

  def add_book(parameters, _readers)
    book_id = @books_list.keys.max + 1
    dot_initials = parameters[:author].split('.')
    initials_author = "#{dot_initials[0]}.#{dot_initials[1]}."
    count_library = get_count_library(parameters[:number])
    book = Book.new(book_id,
                    initials_author,
                    dot_initials[2],
                    parameters[:title],
                    parameters[:number],
                    parameters[:genre],
                    parameters[:age_rating],
                    count_library,
                    0)
    @books_list[book_id] = book
    book_id
  end

  def add_reader(parameters)
    reader_id = @readers_list.keys.max + 1
    reader = Reader.new(reader_id,
                        parameters[:surname],
                        parameters[:name],
                        parameters[:patronymic],
                        parameters[:birthday],
                        [])
    @readers_list[reader_id] = reader
    reader_id
  end

  def delete_book(id)
    @books_list.delete(id)
  end

  def book_recount(book_id, number)
    on_hands = 0
    @books_list.each do |id, book|
      next unless book.number.split('-')[0] == number.split('-')[0]

      if id != book_id
        book.count_library += 1
        on_hands = book.count_hands
      end
      book.count_hands = on_hands
    end
  end

  def down_recount_book(book_id, readers)
    raw_book = book_by_id(book_id)
    count_on_hands = 0
    readers.all_readers_iterable.each do |_id, reader|
      own_list = readers.own_books_list_by_reader(reader.id)
      own_list.each do |_own_id, own_book|
        if own_book[0].number == raw_book.number
          count_on_hands = 1
          break
        end
      end
    end
    recount_on_library(raw_book, count_on_hands)
  end

  def recount_on_library(raw_book, count_on_hands)
    @books_list.each do |_id, book|
      if book.number.split('-')[0] == raw_book.number.split('-')[0]
        book.count_hands -= count_on_hands
        book.count_library -= 1
      end
    end
  end

  def book_recount_after_delete(reader_id, readers)
    reader = readers.reader_by_id(reader_id)
    list = reader.own_books_list
    @books_list.each do |id, book|
      list.each do |_id_own, own_book|
        next unless book.number == own_book[0].number

        # p id
        reduction_of_books(book.number)
        delete_book(id)
      end
    end
  end

  def reduction_of_books(book_number)
    @books_list.each do |_id, book|
      if book.number.split('-')[0] == book_number.split('-')[0]
        book.count_hands -= 1
        book.count_library -= 1
      end
    end
  end

  def list_of_genre
    list_genre = []
    # @books_list.each do |_id, book|
    #   list_genre.push(book.genre) if !list_genre.include?(book.genre)
    # end
    # list_genre
    # @books_list.select{|genre| }


    # @books_list.values.select do |book|
      # p book
      # list_genre.push(book)
      # list_genre=book.map{|genre| genre}
      # p list_gen
     p @books_list.values.map{|book| book.genre}.uniq
     
    # end  
    # list_genre= @books_list.values.select{|book| genre}
    # p list_genre
  
  end

  def list_of_author
    list_author = []
    @books_list.each do |_id, book|
      author = "#{book.initials_author}#{book.author_surname}"
      list_author.push(author) if !list_author.include?(author)
    end
    list_author
  end

  def sort_by_author_title
    @books_list.values.sort_by { |x| [x.author_surname, x.title] }
  end

  def filter_books(genre)
    sort = sort_by_author_title
    sort.select do |book|
      next if genre && !genre.empty? && !book.genre.downcase.include?(genre.downcase)

      true
    end
  end
end
