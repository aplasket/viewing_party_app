class MovieDataService
  def top_rated_movies
    get_url('3/movie/top_rated')
  end

  def get_url(url)
    binding.pry
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
      faraday.params['api_key'] = ENV['TMBD_API_KEY']
    end
  end
end