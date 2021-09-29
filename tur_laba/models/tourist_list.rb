# frozen_string_literal: true

require 'csv'
require_relative 'tourist'

class TouristList
  DATA_TOURISTS = File.expand_path('../data/tourists.csv',__dir__)

  def initialize
    @tourist_list = []
    read_data_tourist
  end

  def read_data_tourist
    return unless File.exist?(DATA_TOURISTS)
 
    id = 0
    CSV.foreach(DATA_TOURISTS, headers: false) do |row|
      push_to_tourists(id, row)
      id += 1
    end
    @tourist_list = @tourist_list.map do |tourist|
      [tourist.id, tourist]
    end.to_h
  end

  def push_to_tourists(id, row)
    list_of_wishes = get_wishes_list(row[3]) unless row[3].nil?
    tourist = Tourist.new(id,row[0],row[1],row[2],list_of_wishes)
    @tourist_list.push(tourist)
  end

  def get_wishes_list(list_wishes)
    list_of_wishes = []
    list_wishes = list_wishes.split(';')
    i = 0
    id = 0
    list_wishes.each do |wish|
      list_of_wishes.push([id, wish])
      id += 1
    end
     
    list_of_wishes = list_of_wishes.map do |wish_id, wish|
        [wish_id, wish]
    end.to_h
  end

  def all_tourists
    @tourist_list.values
  end
   
  def tourist_by_id(id)
    @tourist_list[id]
  end

  def delete_tourist(id)
    @tourist_list.delete(id)
  end

  def tourist_add(parameters)
    tourist_id = @tourist_list.keys.max + 1
    wish_list = get_wishes_list(parameters[:list_of_wishes])
    @tourist_list[tourist_id] = Tourist.new(
      tourist_id,
      parameters[:surname],
      parameters[:name],
      parameters[:patronymic],
      wish_list
    )
  end

  def group_by_counry_and_transport
    group = Hash.new
    @tourist_list.values.each do |tourist|
      if group.has_key?("#{tourist.list_of_wishes[0]},#{tourist.list_of_wishes[2]}")
        group["#{tourist.list_of_wishes[0]},#{tourist.list_of_wishes[2]}"].push(tourist)
      else
        group["#{tourist.list_of_wishes[0]},#{tourist.list_of_wishes[2]}"] = [tourist]
      end
    end
    group
  end

  def count_tourist(country)
    k = 0
    @tourist_list.values.each do |tourist|
      if tourist.list_of_wishes[0] == country
         k += 1
      end
    end 
    return k
  end
  
  def popular_transport(country)
    h = Hash.new
    k =''
      @tourist_list.values.each do |tourist|
      if tourist.list_of_wishes[0] == country
        if h.has_key?("#{tourist.list_of_wishes[0]}")
          h["#{tourist.list_of_wishes[2]}"]+=1
        else 
          h["#{tourist.list_of_wishes[2]}"] = 1
        end
      end
    end
    k= h.key(h.values.max)
    return k
  end

  def select_tourist(tour)
    arr =[]
    @tourist_list.values.each do |tourist|
      if tourist.list_of_wishes[0]==tour.country && select_by_place(tour,tourist) && select_by_money(tour,tourist) && select_by_days(tourist,tour) && tour.transport == tourist.list_of_wishes[2]
        arr.push(tourist)
      end
    end
    return arr
  end

  def select_by_place(tour,tourist)
    tour.sight.each do |id, sight|
      if tourist.list_of_wishes[1] == sight
        return true
      end
    end
  end

  def select_by_money(tour,tourist)
    arr = tourist.list_of_wishes[4].split('-')
    return tour.cost.to_i >= arr[0].to_i && tour.cost.to_i <= arr[1].to_i
  end
  
  def select_by_days(tourist,tour)
    arr = tourist.list_of_wishes[3].split('-')
    return tour.count_days.to_i >= arr[0].to_i && tour.count_days.to_i <= arr[1].to_i
  end


end