require "rails_helper"

RSpec.describe Movie, :vcr do
  before(:each) do
    params = {id: 238}
    @movie = MovieFacade.new(params).movie
  end

  it "exists and has attributes" do
    expect(@movie).to be_a(Movie)
    expect(@movie.id).to be_an(Integer)
    expect(@movie.id).to eq(238)
    expect(@movie.title).to be_a(String)
    expect(@movie.title).to eq("The Godfather")
    expect(@movie.vote_average).to be_an(Float)

    expect(@movie.genres).to be_an(Array)
    expect(@movie.overview).to be_a(String)
    expect(@movie.runtime).to be_an(Integer)
    expect(@movie.runtime).to eq(175)
    expect(@movie.poster_path).to be_a(String)
    expect(@movie.poster_path).to eq("/3bhkrj58Vtu7enYsRolD1fZdja1.jpg")
  end
end
