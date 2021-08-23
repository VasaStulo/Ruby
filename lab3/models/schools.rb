# frozen_string_literal: true

require_relative 'students'
require 'forwardable'

# This class performs operations on the "school" attribute
class Schools
  extend Forwardable
  def_delegator :@schools, :each, :each_school

  def initialize
    @schools = []
  end

  def include_school(type, number)
    @schools.each do |school|
      return false if school.type == type && school.number == number
    end
    true
  end

  def list_schools(students)
    school_id = 1
    @schools = []
    students.each do |student|
      type = student.school.split(' ')[0]
      number = student.school.split(' ')[1].split('№')[1].to_i
      if include_school(type, number)
        @schools.push(School.new(school_id, type, number))
        school_id += 1
      end
    end
    @schools
  end

  def sort_list_schools(schools)
    schools.sort_by { |x| [x.type, x.number] }
  end

  def school_by_id(id)
    @schools.each do |school|
      return school if school.id == id
    end
  end

  def filter_by_type(schools, type)
    filtered_schools = []
    schools.select do |school|
      filtered_schools.push(school) if school.type == type.to_s
    end
  end

  def all_schools
    @schools.dup
  end
end
