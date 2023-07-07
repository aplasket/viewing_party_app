class MoviesController < ApplicationController
  def index
    @keyword = params[:q]
    @user = User.find(params[:user_id])
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = ENV["TMDB_API_KEY"]
    end
    if @keyword == "top%20rated"
      response = conn.get("/3/movie/top_rated")
    else
      response = conn.get("/3/search/movie?query=#{@keyword}")
    end

    json = JSON.parse(response.body, symbolize_names: true)
    @movies = json[:results].map {|movie_data| Movie.new(movie_data)} 
    # require 'pry'; binding.pry
  end
  
  def show; end
  
end
