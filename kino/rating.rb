class Rating
  def initialize(title,imdb,kinopiosk,metacritic,rotten_tomatoes)
    @title = title
    @imdb = Integer(imdb)
    @kinopiosk = Integer(kinopiosk)
    @metacritic = Integer(metacritic)
    @rotten_tomatoes = Integer(rotten_tomatoes)
  end

  def to_s
    "#{@title},#{@imdb},#{@kinopiosk},#{@metacritic},#{@rotten_tomatoes}"
  end
  
end
