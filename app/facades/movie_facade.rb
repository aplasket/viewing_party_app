class MovieFacade
  attr_reader :keyword,
              :user_id

  def initialize(params)
    @keyword = params[:keyword]
    @user_id = params[:user_id]
    @movie_id = params[:id]
  end

  def title_statement
    if @keyword
      "Movie results for: #{@keyword}"
    else
      "Top Movies"
    end
  end

  def movies
    if @keyword
      make_movies(service.search_movies_by_keyword(@keyword))
    else
      make_movies(service.find_top_movies)
    end
  end

  def make_movies(json)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def service
    MovieService.new
  end

  def movie
    Movie.new(service.movie_details(@movie_id))
  end

  def credits
    Credit.new(service.movie_credits(@movie_id))
  end

  def reviews
    Review.new(service.movie_reviews(@movie_id))
  end

  def images
    image_data = Movie.new(service.movie_images(@movie_id)).first

    "https://image.tmdb.org/t/p/original#{image_data[:file_path]}"
  end
end
