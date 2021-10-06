# frozen_string_literal: true

require 'csv'
require_relative 'group'
# Class for action with groups
class GroupList
  def initialize(lessons_list = [])
    @lessons_list = lessons_list
    @group_list = []
    generate_groups
  end

  def generate_groups
    id = 0
    @lessons_list.each do |lesson|
      next if @group_list.include?(lesson.group)

      flag = false
      @group_list.each do |group|
        flag = true if group.name == lesson.group
      end
      next if flag

      group = Group.new(id, lesson.group)
      @group_list.push(group)
      id += 1
    end

    @group_list = @group_list.map do |group|
      [group.id, group]
    end.to_h
  end

  def all_groups
    @group_list.values
  end

  def filter_group(name)
    @group_list.values.select do |group|
      next if
      name && !name.empty? && !group.name.downcase.include?(name.downcase)

      true
    end
  end

  def in_group(group_name)
    @group_list.each_value do |group|
      return true if group.name == group_name
    end
    false
  end
end
