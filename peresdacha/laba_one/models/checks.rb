#frozen_string_literal: true

require 'csv'
require_relative 'check'
class Checks

  def initialize
    @check_list = []
    read_data_checks
  end 
  
  DATA_CHECKS = File.expand_path('../data/check_data.csv',__dir__)


  def read_data_checks
    return unless File.exist?(DATA_CHECKS)
    id = 0
    CSV.foreach(DATA_CHECKS, headers: false) do |row|
        all_list = row[4].split(".")
        list_products = Products.new(all_list)
        check = Check.new(id, row[0], row[1],row[2],row[3],list_products)
        @check_list.push(check)
        @check_list[check.id] = check
        id+=1
    end
    hash_check
  end 

  def hash_check
      @check_list = @check_list.map do |check|
      [check.id, check]
    end.to_h
  end 

  def all_checks
    @check_list.values
  end

  def add_check(parameters)
    check_id = @check_list.keys.max + 1
    check = Check.new( check_id,
                        parameters[:date],
                        parameters[:time],
                        parameters[:place],
                        parameters[:number],
                        [])
    @check_list[check_id] = check
    check_id
  end

  def check_by_id(id)
    @check_list[id]
  end

  def delete_check(check_id)
    @check_list.delete(check_id)
  end
  
  def filter_checks(parameters)
    @check_list.each do|id, check|
      # p check
      check.products_list.all_products.each do |pr, id|
        if pr.category == parameters[:category]
          puts"true"
        end
      end 
      true
    end
    # p parameters[:category]
    # p @check_list.products_list.all_products.map{|check| check.category}
  end


end
