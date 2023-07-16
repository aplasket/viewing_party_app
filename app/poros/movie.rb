class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :genres,
              :overview,
              :runtime,
              :poster_path

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @genres = data[:genres]
    @overview = data[:overview]
    @runtime = data[:runtime]
    @poster_path = data[:poster_path]
  end
end
