require "rails_helper"

RSpec.describe "/users/:user_id/movies/:movie_id/viewing-party/new" do
  before(:each) do
    @user = User.create!(name: "Silly Billy", email: "silly_billy@email.com", password: "test123", password_confirmation: "test123")
    @user2 = User.create!(name: "Michael", email: "michael@email.com", password: "test", password_confirmation: "test")
    @user3 = User.create!(name: "Tula", email: "tula@email.com", password: "test415", password_confirmation: "test415")
    @movie = MovieFacade.new({id: 238}).movie

    visit login_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Submit"

    visit new_movie_viewing_party_path(@movie.id)
  end

  describe "as a user on the viewing party page" do
    describe "the page has a title and discover button" do
      it "has a page title of Create a Movie Party for the 'Movie title'", :vcr do
        expect(page).to have_content("Create a Movie Party")
      end

      it "has a button to return to the discover movies page", :vcr do
        click_on "Discover Movies"

        expect(current_path).to eq(discover_path)
      end
    end

    describe "has a viewing party details form" do
      it "the page displays a form title", :vcr do
        expect(page).to have_content("Viewing Party Details")
      end

      it "has a fill in portion of the form", :vcr do
        within(".party_details") do
          expect(page).to have_content("Movie Title: #{@movie.title}")
          expect(page).to have_content("Duration of Party")
          fill_in :duration, with: 190
          fill_in :party_date, with: "12/02/22"
          fill_in :party_time, with: Time.now
          expect(page).to have_content("Invite Other Users")
          check @user2.name.to_s
          click_button "Create Party"
        end

        expect(current_path).to eq(dashboard_path)
      end

      # sad path
      it "if form is not completely filled out, error message displays", :vcr do
        within(".party_details") do
          fill_in :duration, with: 200
          fill_in :party_date, with: "01/01/2024"

          click_button "Create Party"
        end

        expect(current_path).to eq(new_movie_viewing_party_path(@movie.id))
        expect(page).to have_content("Error: All fields must be filled in!")
      end
    end
  end
end
