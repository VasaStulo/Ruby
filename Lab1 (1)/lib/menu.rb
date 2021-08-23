# frozen_string_literal: true

require_relative '../lib/buyer'
require_relative '../lib/buyers'
require "fileutils"

class Menu
  def initialize
    @buyers = Buyers.new
    @buyers.read_in_csv_data(File.expand_path('../data/discount.csv', __dir__))
  end

  def display_menu
    loop do
      puts "1) Составить статистику.
  2) Составить персональные приглашения.
  3) Завершить работу.
  Введите число: "
  
      ans = gets.chomp
  
      if ans == '1'
        display_statistic
      end
       if ans == '2'
        create_welcomes
       end
      if ans == '3'
        exit(0)
      end
    end
  end

  def display_statistic
    puts "Общее количество покупателей: #{@buyers.total_buyers_count}"
          puts "Общее сумма покупок: #{@buyers.total_value_costs_purchases}"
          total_one_purchases = 0
          total_one_purchases = @buyers.total_only_one_purchases
          if total_one_purchases.zero?
            puts "Все покупатели совершили не одну покупку"
          else
            puts "Количество покупателей, совершивших единственную покупку: #{total_one_purchases}"
          end
  end

  def create_welcomes
    puts "Введите путь в файловой системе: "
    path = gets.chomp
    Dir.mkdir("#{path}/discounts") unless File.exists?("#{path}/discounts")
    # end

    random_users = @buyers.buyers_list.sample(100)

    random_users.each do |user| 
      File.open("#{path}/discounts/discount_#{user.card}.txt", 'w+') do |file|
      end
    end
  end
end