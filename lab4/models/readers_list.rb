# frozen_string_literal: true

require 'csv'
require_relative 'reader'

#  A class for working with reader methods
class ReadersList
  DATA_READERS = File.expand_path('../data/readers.csv', __dir__)

  def initialize(books)
    @books = books
    @readers_list = []
    read_data_reader
  end

  def read_data_reader
    return unless File.exist?(DATA_READERS)
    id = 0
    CSV.foreach(DATA_READER, headers: false) do |row|
      push_to_readers_list(id, row)
      id += 1
    end
    @readers_list = @readers_list.map do |reader|
      [reader.id, reader]
    end.to_h
  end

  def push_to_readers_list(id, row)
    own_books_list = get_own_books_list(row) unless row[4].nil?
    reader = Reader.new(id, row[0], row[1], row[2], row[3], own_books_list)
    @readers_list.push(reader)
  end

  def get_own_books_list(row)
    own_books_list = []
    list = row[4].split(';')
    i = 0
    id = 0
    while i != list.size
      invent_number = list[i]
      book = @books.book_by_invent_number(invent_number)
      own_books_list.push([id, book, list[i + 1]])
      id += 1
      i += 2
    end
    own_books_list = own_books_list.map do |own_id, own_book, own_date|
      [own_id, [own_book, own_date]]
    end.to_h
    own_books_list
  end

  def reader_by_id(id)
    @readers_list[id]
  end

  def all_readers_iterable
    @readers_list.dup
  end

  def all_readers
    @readers_list.values
  end

  def own_books_list_by_reader(reader_id)
    reader_by_id(reader_id).own_books_list
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

  def book_in_own_list_by_id(reader_id, id)
    own_list = own_books_list_by_reader(reader_id)
    own_list[id]
  end

  def delete_reader(id)
    @readers_list.delete(id)
  end

  def book_add_to_reader(parameters, reader_id)
    if !book_check(parameters[:number])
      book = @books.book_by_invent_number(parameters[:number])
      if !book.nil?
        book.count_hands += 1
        date = parameters[:date]
        own_list = own_books_list_by_reader(reader_id)
        max_own_book = own_list.keys.max + 1
        own_list[max_own_book] = [book, date]
      end
    end
    max_own_book
  end

  def book_check(number)
    flag = false
    @readers_list.each do |_id, reader|
      reader.own_books_list.each do |_id, own_book|
        if own_book[0].number == number
          flag = true
          break
        end
      end
    end
    flag
  end

  def removal_book_from_reader(book_id, books)
    @readers_list.each do |_id, reader|
      book = books.book_by_id(book_id)
      list = reader.own_books_list
      list.each do |id, book_reader|
        next unless book.number == book_reader[0].number

        list.delete(id)
      end
    end
  end
end
