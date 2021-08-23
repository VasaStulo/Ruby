require 'csv'
require_relative 'buyer'
require 'pry'

class Buyers 
  attr_reader :buyers_list #Не должен быть доступен извне!!
  def initialize
    @buyers_list = []
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, col_sep: ';', row_sep: :auto, headers:true) do |row|
      buyer = Buyer.new(row['Фамилия'],row['Имя'],row['Отчество'],row['Номер карты'], row['Общая сумма покупок'], row['Последняя покупка'], row['Бонусы'])
      # binding.pry
      # puts row[0]
      @buyers_list.append(buyer)
    end
  end

  def total_buyers_count
    @buyers_list.size()
  end

  def total_value_costs_purchases
    @buyers_list.reduce(0){ |sum, buyer| sum + buyer.totalAmount}
  end 

  def total_only_one_purchases
    count = 0
    @buyers_list.each do |buyer|
      if buyer.totalAmount == buyer.sizeLastPurchase
        count+=1
      end
    end
    count
  end 

end