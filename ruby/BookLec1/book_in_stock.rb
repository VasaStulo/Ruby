#frozen_string_literal: true

class BookInStock
  attr_reader :isbn
  attr_reader :price
 
  def initialize (isbn,price)
    @isbn = isbn
    @price = Float(price)
  end

  def to_s
    "ISBN: #{@isbn},price:#{@price}"
  end

end

