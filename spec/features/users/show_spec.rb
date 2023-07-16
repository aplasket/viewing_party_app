require "rails_helper"

RSpec.describe "user_path(user)", type: :feature do
  describe "on a user dashboard" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    before(:each) do
      @movie1 = MovieFacade.new({id: 500}).movie
      @movie2 = MovieFacade.new({id: 400}).movie
      @party1 = Party.create!(duration: 100, party_date: "08/02/23" , party_time: "12:00", movie_id: @movie1.id)
      @party2 = Party.create!(duration: 120, party_date: "08/03/23", party_time: "8:00", movie_id: @movie2.id)
      @u1p1 = UserParty.create!(user_id: user.id, party_id: @party1.id, is_host: true)
      @u2p1 = UserParty.create!(user_id: user2.id, party_id: @party1.id, is_host: false)
    end

    it "should render only the user's name", :vcr do
      visit user_path(user)

      expect(page).to have_content("#{user.name}'s Dashboard")
      expect(page).to_not have_content("#{user2.name}'s Dashboard")
    end

    it "routes me to the discover movies dashboard", :vcr do
      visit user_path(user)
      click_button "Discover Movies"
      expect(current_path).to eq(user_discover_index_path(user))
    end

    it "should render the parties the user is invited to", :vcr do
      visit user_path(user2)
      # require 'pry'; binding.pry
      within ".invited_to_parties" do
        expect(page).to have_content(@movie1.title) #Reservoir Dogs
        expect(page).to have_content(@party1.party_date.strftime("%B %d, %Y"))
        expect(page).to have_content(@party1.party_time.strftime("%I:%M%p"))
        expect(page).to have_content("Invited")
      end

      visit user_path(user)
      within ".hosting_parties" do
        expect(page).to have_content(@movie1.title) #Reservoir Dogs
        expect(page).to have_content(@party1.party_date.strftime("%B %d, %Y"))
        expect(page).to have_content(@party1.party_time.strftime("%I:%M%p"))
        expect(page).to have_content("Hosting")
      end
    end
  end
end
