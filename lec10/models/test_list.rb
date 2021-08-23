#Позволяет пропбросить методы на исполнение
require 'forwardable'

class TestList
  extend Forwardable
  def_delegator :@tests, :each, :each_test

  def initialize(tests = [])
    @tests = tests
  end

  def all_tests
    @tests.dup
  end

  def add_test(test)
    @tests.append(test)
  end

  def filter(date,duration)
    @tests.select do |test|
      next if date && !date.empty? && date != test.date
      next if duration && !duration.empty? && !test.duration.include?(duration)

      true
    end
  end
end