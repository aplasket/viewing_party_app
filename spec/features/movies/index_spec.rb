require "rails_helper"

RSpec.describe "/users/:user_id/movies?, Movies Results", type: :feature do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  before(:each) do 
    @movie_data  = 
    {
        "adult": false,
        "backdrop_path": "/35z8hWuzfFUZQaYog8E9LsXW3iI.jpg",
        "genre_ids": [
            12,
            28,
            14
        ],
        "id": 335977,
        "original_language": "en",
        "original_title": "Indiana Jones and the Dial of Destiny",
        "overview": "Finding himself in a new era, approaching retirement, Indy wrestles with fitting into a world that seems to have outgrown him. But as the tentacles of an all-too-familiar evil return in the form of an old rival, Indy must don his hat and pick up his whip once more to make sure an ancient and powerful artifact doesn't fall into the wrong hands.",
        "popularity": 746.567,
        "poster_path": "/Af4bXE63pVsb2FtbW8uYIyPBadD.jpg",
        "release_date": "2023-06-28",
        "title": "Indiana Jones and the Dial of Destiny",
        "video": false,
        "vote_average": 6.6,
        "vote_count": 463
    }

  #   @indiana_jones = Movie.new(movie_data)
  end


  describe "As a user, when I visit the movie results page from the discover movies page" do
    it "I see a button to go back to the Discover Page" do
      visit user_movies_path(user1)
      click_button "Discover Page"
      expect(current_path).to eq(user_discover_index_path(user1))
    end

    it "displays top rated movies if chosen from discover page" do
      visit user_discover_index_path(user2)

      click_button "Find Top Rated Movies"
      within(".results") do
        expect(page).to have_content("The Godfather Vote Average: 8.7")
        expect(page).to have_content("Schindler's List Vote Average: 8.6")
        expect(page).to have_content("12 Angry Men Vote Average: 8.5")
      end
    end
    
    it "displays the movie title as a link to the movie details page" do
      visit user_discover_index_path(user1)
      
      within(".search-movies") do
        fill_in(:q, with: "Indiana Jones and the Dial of Destiny")
        click_button "Find Movies"
      end
      
      within(".results") do 
        expect(page).to have_link("Indiana Jones and the Dial of Destiny")
        click_link "Indiana Jones and the Dial of Destiny"
      end

      expect(current_path).to eq(user_movie_path(user1, @movie_data[:id] ))
    end

    it "displays the vote average of the movie" do
      visit user_discover_index_path(user2)

      within(".search-movies") do
        fill_in(:q, with: "Indiana Jones and the Dial of Destiny")
        click_button "Find Movies"
      end

      within(".results") do
        expect(page).to have_content("Vote Average: #{@movie_data[:vote_average]}")
      end
    end
  end
end
