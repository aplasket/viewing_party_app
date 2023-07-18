class MovieService
  def find_top_movies
    get_url("movie/top_rated")
  end

  def search_movies_by_keyword(keyword)
    get_url("search/movie?query=#{keyword}")
  end

  def movie_details(movie_id)
    get_url("movie/#{movie_id}")
  end

  def movie_credits(movie_id)
    get_url("movie/#{movie_id}/credits")
  end

  def movie_reviews(movie_id)
    get_url("movie/#{movie_id}/reviews")
  end

  def movie_images(movie_id)
    get_url("movie/#{movie_id}/images")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = ENV["TMDB_API_KEY"]
    end
  end
end
