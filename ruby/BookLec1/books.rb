#frozen_string_literal: true

#Для подключения глобальных библиотек 
require 'csv'
require_relative 'book_in_stock'
require 'pry'

class Books 
  def initialize
    @books = []
  end

  #Считываем файл с помощью метода foreach,headers:true-для чтения заголовков столбцов из файла
  def read_in_csv_data(file_name)
    CSV.foreach(file_name, headers:true) do |row|
      #Создаем объект
      binding.pry
      book = BookInStock.new(row['ISBN'],row['Price'])
      #добавляем его в массив books
      @books.append(book)
    end
  end

  #Метод, подсчитывающий общую стоимость книг
  def total_value_in_stock
    #reduce позволить прости весь массив, собрав общую характеристику
    @books.reduce(0.0){ |sum, book| sum + book.price}
end

  #Метод,считающий количество книг по isbn
  def book_count_by_isbn
    isbn_hash = Hash.new(0)
    @books.each do |book|
      isbn_hash [book.isbn] +=1
    end
  isbn_hash
  end
end
