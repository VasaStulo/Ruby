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
    # p @tourist_list
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
   
  

end