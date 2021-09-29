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

  def tour_by_id(id)
    @tour_list[id]
  end

  def tour_add(parameters)
    tour_id = @tour_list.keys.max + 1
    sight_list = get_sight_list(parameters[:sight])
    @tour_list[tour_id] = Tour.new(
      tour_id,
      parameters[:country],
      parameters[:city],
      parameters[:count_days],
      parameters[:transport],
      parameters[:cost],
      parameters[:max_people],
      sight_list
    )
  end

  def delete_tour(id)
    @tour_list.delete(id)
  end

  def select_tur(tourist)
    arr= []
    @tour_list.each do |id,tour|
      if tour.country == tourist.list_of_wishes[0] && tour.transport == tourist.list_of_wishes[2] && select_by_money(tourist,tour) && select_by_days(tourist,tour) && select_by_place(tourist,tour)
        arr.push(tour)
        # p arr
      end
    end
    return arr
  end
  
  def select_by_money(tourist,tour)
    arr = tourist.list_of_wishes[4].split('-')
    return tour.cost.to_i >= arr[0].to_i && tour.cost.to_i <= arr[1].to_i
  end
  
  def select_by_days(tourist,tour)
    arr = tourist.list_of_wishes[3].split('-')
    return tour.count_days.to_i >= arr[0].to_i && tour.count_days.to_i <= arr[1].to_i
  end

  def select_by_place(tourist,tour)
    tour.sight.each do |id, sight|
      if tourist.list_of_wishes[1] == sight
        return true
      end
    end
  end

  def list_of_country
    arr = @tour_list.values.map{|x| x.country}.uniq
  end

  def count_tour_by_country(country)
    k = 0
    @tour_list.each do |id, tour|
      if tour.country == country
          k+=1
      end
    end
    return k
  end
   
  def count_city_for_visit(country)
    k = 0
    arr = []
    @tour_list.each do |id, tour|
      if tour.country == country
          arr.push(tour.city)
      end
    end
    k = arr.length 
    return k
  end

  def count_sight_by_country(country)
    k=0
    arr = []
    @tour_list.each do |id, tour|
      if tour.country == country
        tour.sight.each do |id, sight|
          arr.push(sight)
        end
      end
    end
    k = arr.uniq.length
  end

  def average_days(country)
    sum = 0
    k = count_tour_by_country(country)
    @tour_list.each do |id, tour|
      if tour.country == country
        sum += tour.count_days.to_i
      end
    end
    aver = sum/k
    return aver
  end

  def common_transport(country)
    h = Hash.new
    k =''
      @tour_list.each do |id, tour|
      if tour.country == country
        if h.has_key?("#{tour.transport}")
          h["#{tour.transport}"]+=1
        else 
          h["#{tour.transport}"] = 1
        end
      end
    end
    k= h.key(h.values.max)
    return k
  end
  
  def average_cost(country)
    sum=0
        k = count_tour_by_country(country)
    @tour_list.each do |id, tour|
      if tour.country == country
        sum += tour.cost.to_i
      end
    end
    aver = sum/k
    return aver
  end
end