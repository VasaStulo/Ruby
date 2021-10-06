# frozen_string_literal: true

require 'csv'
require_relative 'lesson'

# Classroom for actions with training records
class LessonList
  DATA_LESSONS = File.expand_path('../db/schedule.csv', __dir__)

  def initialize
    @lesson_list = []
    read_data_lessons
  end

  def read_data_lessons
    return unless File.exist?(DATA_LESSONS)

    id = 0
    CSV.foreach(DATA_LESSONS, headers: false) do |row|
      lesson = Lesson.new(id, row[0], row[1], row[2], row[3], row[4], row[5])
      @lesson_list.push(lesson)
      id += 1
    end
    @lesson_list = @lesson_list.map do |lesson|
      [lesson.id, lesson]
    end.to_h
  end

  def all_lessons
    @lesson_list.values
  end

  def uniq_groups
    @lesson_list.values.map(&:group).uniq
  end

  def get_shedule(group_name)
    week_shedule = {}
    @lesson_list.each do |_id, lesson|
      if lesson.group == group_name
        if week_shedule.key?(lesson.day)
          week_shedule[lesson.day].push(lesson)
        else
          week_shedule[lesson.day] = [lesson]
        end
      end
    end

    week_shedule.each do |id, item|
      item = item.sort_by(&:number)
      week_shedule[id] = item
    end
  end
end
