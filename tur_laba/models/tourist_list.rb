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

end