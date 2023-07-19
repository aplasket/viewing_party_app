require "rails_helper"

RSpec.describe "movies_path", type: :feature do
  let!(:user) { create(:user, password: "test123", password_confirmation: "test123") }

  before(:each) do
    visit login_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on "Submit"
  end
  
  describe "when a user visits the discovery page" do
    describe "and they click on Find Top Rated Movies", :vcr do
      it "routes to a movie index page where the top movies are rendered" do
        visit discover_path

        click_button("Find Top Rated Movies")

        expect(current_path).to eq(movies_path)

        expect(page).to_not have_content("Movie results for:")

        expect(page).to have_css(".movie", maximum: 20)

        within(first(".movie")) do
          expect(page).to have_css(".title")
          expect(page).to have_css(".vote_avg")
          expect(page).to have_content("Vote Average:")
        end
      end
    end

    describe "they search for a movie in the search bar", :vcr do
      it "routes to the movie index page where search results are rendered" do
        visit discover_path

        within ".search-movies" do
          fill_in "Search:", with: "Princess"
          click_button "Find Movies"
        end

        expect(current_path).to eq(movies_path)

        expect(page).to have_content("Movie results for: Princess")
        expect(page).to have_css(".movie", maximum: 20)

        within(first(".movie")) do
          expect(page).to have_css(".title")
          expect(page).to have_css(".vote_avg")
          expect(page).to have_content("Vote Average:")
        end
      end
    end
  end

  describe "as a user on the movie index page" do
    it "displays a button to return back to the discover page", :vcr do
      visit movies_path

      click_button "Discover Page"

      expect(current_path).to eq(discover_path)
    end
  end
end
