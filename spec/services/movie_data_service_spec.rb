require "rails_helper"

RSpec.describe MovieDataService do
  describe "connection" do
    it "can retrieve a list of the top 20 movies" do
      top_rated = MovieDataService.new.top_rated_movies

      expect(top_rated).to be_a(Hash)
      expect(top_rated[:results]).to be_an(Array)
      expect(top_rated[:results].first[:title]).to be_a(String)
      expect(top_rated[:results].count).to eq(20)

      movie = top_rated[:results].first
      binding.pry
    end
  end
end