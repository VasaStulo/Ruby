require 'csv'

class Ratings
  attr_reader :ratings_list
  def initialize
    @ratings_list = []
  end


def read_in_csv(file_name)
  CSV.foreach(file_name, headers:true) do |row|
    rating = Rating.new(row['title'],row['kinopoisk'],row['imdb'],row['metacritic'],row['rotten_tomatoes'])
    @ratings_list.append(rating)
  end
end
end