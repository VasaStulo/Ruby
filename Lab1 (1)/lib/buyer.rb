# frozen_string_literal: true

class Buyer
  attr_reader :surname, :name, :patronymic, :card, :totalAmount, :sizeLastPurchase, 
 :numberOfBonuse

  def initialize(surname, name, patronymic, card, totalAmount, sizeLastPurchase, 
   numberOfBonuses)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @card = card
    @totalAmount = Integer(totalAmount)
    @sizeLastPurchase= Integer(sizeLastPurchase)
    @numberOfBonuses = Integer(numberOfBonuses)
  end

  def to_s
    "#{@surname},#{@name},#{@patronymic},#{@card},#{@totalAmount},#{@sizeLastPurchase},#{@numberOfBonuses}"
  end
  
  
end
