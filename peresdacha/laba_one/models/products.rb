# frozen_string_literal: true

require 'csv'
require_relative 'product'
class Products

  DATA_PRODUCT = File.expand_path('../data/product_data.csv',__dir__)

  def initialize(all_list = [])
    @product_list = []
    read_data(all_list)
  end

  def read_data(all_list)
    id = 0
    all_list.each do |param|
      arr = param.split(";")
      product = Product.new(id, arr[0],arr[1],arr[2].to_i,arr[3],arr[4])
      @product_list.push(product)
      @product_list[product.id]= product
      id +=1
    end
    hash_product
    end

  def hash_product
      @product_list = @product_list.map do |product|
      [product.id, product]
    end.to_h
  end 

  def all_products
    @product_list.values
  end

  def filter_products(params)
  #   @product_list.each do |id, pr|
  #     p id
  # end
   p @product_list
  end
end