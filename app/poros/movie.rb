class Movie
  attr_reader :id,
              :title,
              :overview,
              :run_time,
              :genres,
              :poster,
              :vote_average

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @overview = data[:overview]
    @run_time = data[:runtime]
    @genres = data[:genres]
    @poster = data[:poster_path]
    @vote_average = data[:vote_average]
  end
end

#https://developer.themoviedb.org/reference/movie-details
#https://developer.themoviedb.org/reference/movie-top-rated-list