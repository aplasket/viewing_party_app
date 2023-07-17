require "rails_helper"

RSpec.describe MovieFacade do
  describe "#movies", :vcr do
    it "can find top rated movies and make movie objects" do
      user = create(:user)
      params = {user_id: user.id}
      top_movies = MovieFacade.new(params).movies

      expect(top_movies).to be_an(Array)

      top_movies.each do |top_movie|
        expect(top_movie).to be_a(Movie)
        expect(top_movie.title).to be_a(String)
        expect(top_movie.id).to be_an(Integer)
        expect(top_movie.vote_average).to be_a(Float)
      end
    end

    it "can search movies by keyword" do
      user = create(:user)
      params = {keyword: "Princess"}
      movies_by_keyword = MovieFacade.new(params).movies

      expect(movies_by_keyword).to be_an(Array)

      movies_by_keyword.each do |keyword_movie|
        expect(keyword_movie).to be_a(Movie)
      end
    end
  end

  describe "#movie", :vcr do
    it "gets movie details" do
      user = create(:user)
      params = {id: 238}
      movie = MovieFacade.new(params).movie

      expect(movie).to be_a(Movie)
      expect(movie.title).to eq("The Godfather")
      expect(movie.vote_average).to eq(8.71)
      expect(movie.runtime).to eq(175)
      expect(movie.overview).to be_a(String)
    end
  end

  describe "#credits", :vcr do
    it "fetches movie credit info" do
      user = create(:user)
      params = {user_id: user.id, id: 238 }
      credits = MovieFacade.new(params).credits.cast

      expect(credits).to be_an(Array)
      expect(credits.first).to eq(["Marlon Brando", "Don Vito Corleone"])
      expect(credits.first).to be_an(Array)
      expect(credits.count).to eq(10)
    end
  end

  describe "#reviews", :vcr do
    it "fetches a movie's review info" do
      user = create(:user)
      params = {user_id: user.id, id: 238 }
      reviews = MovieFacade.new(params).reviews.all_reviews

      expect(reviews).to be_an(Array)
      expect(reviews.first).to be_a(String)
      expect(reviews.count).to eq(5)
      expect(reviews.last).to eq("Suresh Chidurala's review: Great Movie **Ever**")
    end
  end
end
