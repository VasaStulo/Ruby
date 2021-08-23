# frozen_string_literal: true

require 'csv'
require_relative 'student'

# Class for secondary methods for "students
class Students
  attr_reader :students

  DATA_STUDENTS = File.expand_path('../data/students.csv', __dir__)

  def initialize
    @students = []
    read_data
  end

  def read_data
    return unless File.exist?(DATA_STUDENTS)

    CSV.foreach(DATA_STUDENTS, headers: false) do |row|
      student = Student.new(row[0], row[1], row[2], row[3], row[4], row[5], row[6])
      @students.push(student)
    end
  end

  def count_girl(school)
    count = 0
    @students.each do |student|
      if student.school == "#{school.type} №#{school.number}" &&
         student.sex == 'женский'
        count += 1
      end
    end
    count
  end

  def count_boys(school)
    k = 0
    @students.each do |student|
      if student.school == "#{school.type} №#{school.number}" &&
         student.sex == 'мужской'
        k += 1
      end
    end
    k
  end

  def sort_full_name(students)
    students.sort_by { |x| [x.surname, x.name, x.patronymic] }
  end

  def filter_by_letter(students, letter)
    filtered = []
    students.select do |student|
      filtered.push(student) if student.surname[0] == letter
    end
    filtered
  end
end
