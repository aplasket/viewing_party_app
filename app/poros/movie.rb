class Movie 
  attr_reader :title,
              :backdrop_path,
              :movie_id,
              :vote_average,
              :genre_ids,
              :overview,
              :poster_path
              
  def initialize(movie_attributes)
    @title = movie_attributes[:title]
    @backdrop_path = movie_attributes[:backdrop_path]
    @movie_id = movie_attributes[:id]
    @vote_average = movie_attributes[:vote_average]
    @genre_ids = movie_attributes[:genre_ids]
    @overview = movie_attributes[:overview]
    @poster_path = movie_attributes[:poster_path]
  end
end
