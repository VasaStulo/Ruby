# frozen_string_literal: true

require 'csv'
require_relative 'tour'

class TourList
  DATA_TOURS = File.expand_path('../data/tours.csv',__dir__)
  
  def initialize 
    @tour_list = []
    read_data_tour
  end

  def read_data_tour
    return unless File.exist?(DATA_TOURS)

    id = 0
    CSV.foreach(DATA_TOURS, headers: false) do |row|
      push_to_tours(id, row)
      id += 1
    end
    @tour_list = @tour_list.map do |tour|
      [tour.id, tour]
    end.to_h
    # p @tour_list
  end

  def push_to_tours(id, row)
    sight_list = get_sight_list(row[6]) unless row[6].nil?
    tour = Tour.new(id, row[0],row[1],row[2],row[3],row[4],row[5],sight_list)
    @tour_list.push(tour)
  end

  def get_sight_list(list_of_sight)
    sight_list = []
    list_of_sight = list_of_sight.split(';')
    i = 0
    id = 0
    list_of_sight.each do |sight|
      sight_list.push([id, sight])
      id+=1
    end

    sight_list = sight_list.map do |sight_id, sight|
      [sight_id, sight]
    end.to_h
  end

  def all_tours
    @tour_list.values
  end
end