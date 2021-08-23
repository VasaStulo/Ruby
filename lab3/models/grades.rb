# frozen_string_literal: true

require_relative 'students'
# Class for secondary methods for "classes"
class Grades
  def initialize
    @grades = []
  end

  def sort_grades(grades_list)
    grades_list.sort_by { |x| [x.numb.to_i, x.letter] }
  end

  def include_class(numb, letter)
    @grades.each do |grade|
      return false if grade.numb == numb && grade.letter == letter
    end
    true
  end

  def list_grades(students, school)
    grade_id = 1
    @grades = []
    students.each do |student|
      next unless student.school == "#{school.type} №#{school.number}"

      numb, letter = split_grade(student)
      if include_class(numb, letter)
        @grades.push(Grade.new(grade_id, numb, letter))
        grade_id += 1
      end
    end
    @grades
  end

  def split_grade(student)
    if student.grade.length == 3
      numb = student.grade.split('')[0] + student.grade.split('')[1]
      letter = student.grade.split('')[2]
    else
      numb = student.grade.split('')[0]
      letter = student.grade.split('')[1]
    end
    [numb, letter]
  end

  def classmates(students, school, grade_id)
    @students_list = []
    students.each do |student|
      next unless student.school == "#{school.type} №#{school.number}"

      @students_list.push(student) if student.grade == grade_by_id(grade_id)
    end
    @students_list
  end

  def grade_by_id(id)
    @grades.each do |grade|
      return "#{grade.numb}#{grade.letter}" if grade.id == id
    end
  end
end
