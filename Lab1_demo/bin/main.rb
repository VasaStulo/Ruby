# frozen_string_literal: true
require 'pry'
require "fileutils"
require_relative '../lib/students'
require_relative '../lib/student'

def main
  # if Gem.win_platform?
  #   Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  #   Encoding.default_internal = __ENCODING__

  #   [STDIN, STDOUT].each do |io|
  #     io.set_encoding(Encoding.default_external, Encoding.default_internal)
  #   end
  # end

  students = Students.new
  students.read_in_csv_data(File.expand_path('../data/students.csv', __dir__))

  while true
    puts 'Введите пункт меню:
    1) Сформировать общий список в файл.
    2) Сформировать список классов для школы.
    3) Завершить работу.'

    ans = gets.chomp

    if ans == '1'

      # array = students.studentsList.sort { |a, b| comp(a, b) }
      # puts array
      puts students.studentsList
      File.open('school.csv', 'w+') do |file|
      #   arr = students.studentsList
      #   arr.each do |student|
      #     file.write "#{student}\n"
      #   end
      # end
    end

    if ans == '2'

    puts "Введите тип учебного заведения: \n1)Школа\n2)Лицей\n3)Гимназия"
    institution = gets.chomp.to_i
    puts 'Введите номер учебного заведения'
    number = gets.chomp.to_i
    if institution == 1

      sch = "Школа №#{number}"
      flag = false
      students.studentsList.each do |student|
        if student.school == sch
          flag = true
          #Создаю директорий
          directory_name = "Школа_#{number}"
          Dir.mkdir(directory_name) unless File.exists?(directory_name)
        
          break
        end
      end
    end

    if institution == 2
      lyceum = "Лицей №#{number}"
      flag = false
      students.studentsList.each do |student| 
        if student.school == lyceum
          flag = true
          #Создаю директорий 
          directory_name = "Лицей_#{number}"
          Dir.mkdir(directory_name) unless File.exists?(directory_name)
          break
        end
      end
    end

      
    if institution == 3
      gymnasium = "Гимназия №#{number}"
      flag = false
      students.studentsList.each do |student| 
        if student.school == gymnasium
          flag = true
          directory_name = "Гимназия_#{number}"
          Dir.mkdir(directory_name) unless File.exists?(directory_name)     
          break
        end
      end
    end


      if !flag
        puts "Заведения с таким номером не существует"
      end

  end


  end
end

# def find_class_of_school
#   students.studentsList.each do |student|
#     if student.grad == sch
  

# end

def comp(a, b)
  if a.school.split(' ')[1].split('№')[1].to_i - b.school.split(' ')[1].split('№')[1].to_i == 0
    if a.grad.casecmp b.grad == 0
      if a.birthday - b.birthday == 0
      else
        a.birthday - b.birthday
      end
    else
      a.grad <=> b.grad

    end
  end
end
# Вызов main, если файл, в котором мы находимся является названием прогрмаммы
main if __FILE__ == $PROGRAM_NAME
