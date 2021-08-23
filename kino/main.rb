# frozen_string_literal: true
require_relative '../lib/rating_reader'
require_relative '../lib/rating' 

def main
  @ratings = Ratings.new(('intput.csv',__dir__))
  puts @ratings.ratings_list
end

main if __FILE__ == $PROGRAM_NAME
