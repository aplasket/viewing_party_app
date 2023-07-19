require "rails_helper"

RSpec.describe "discover path" do
  before(:each) do
    @user = create(:user)

    visit login_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Submit"

    visit discover_path
  end

  describe "When a user visits discover movies page" do
    it "they see a page title of Discover Movies" do
      expect(page).to have_content("Discover Movies")
    end

    it "has a button to discover top rated movies", :vcr do
      expect(page).to have_button("Find Top Rated Movies")
    end

    it "has a form to find movies via keyword", :vcr do
      within ".search-movies" do
        expect(page).to have_field(:keyword)
        expect(page).to have_button("Find Movies")
      end
    end
  end

  describe "When a user clicks on find top rated movies" do
    it "routes to movies results page", :vcr do
      click_button("Find Top Rated Movies")

      expect(current_path).to eq(movies_path)
    end
  end

  describe "When a user searches for a movie via keyword" do
    it "routes to movie results page for movies with that keyword", :vcr do
      within ".search-movies" do
        fill_in :keyword, with: "Shrek"
        click_button "Find Movies"
      end

      expect(current_path).to eq(movies_path)
    end
  end
end