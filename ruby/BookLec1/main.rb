#frozen_string_literal: true

#Подключаем файл (находящийся в проекте!!!) с названием books
require_relative 'books'

def main
  books = Books.new
  books.read_in_csv_data(File.expand_path('data.csv',__dir__))
  puts "Общая стоимость книг: #{books.total_value_in_stock}"
  puts"Количество книг по ISBN"
  #Обращаемся к объекту, вызываем метод подсчета книг,используем итератор, который пробегается по хешу
  books.book_count_by_isbn.each_pair do |isbn, count|
    puts "#{isbn}: #{count}"
  end
end
#Вызов main, если файл, в котором мы находимся является названием прогрмаммы
main if __FILE__ == $PROGRAM_NAME