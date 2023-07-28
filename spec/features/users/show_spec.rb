require "rails_helper"

RSpec.describe "dashboard path", type: :feature do
  describe "on a user dashboard" do
    let(:user) { create(:user, password: "tests", password_confirmation: "tests") }
    let(:user2) { create(:user, password: "tests123", password_confirmation: "tests123") }

    before(:each) do
      @movie1 = MovieFacade.new({id: 500}).movie
      @movie2 = MovieFacade.new({id: 400}).movie
      @party1 = Party.create!(duration: 100, party_date: "08/02/23" , party_time: "12:00", movie_id: @movie1.id)
      @party2 = Party.create!(duration: 120, party_date: "08/03/23", party_time: "8:00", movie_id: @movie2.id)
      @u1p1 = UserParty.create!(user_id: user.id, party_id: @party1.id, is_host: true)
      @u2p1 = UserParty.create!(user_id: user2.id, party_id: @party1.id, is_host: false)
      @u1p2 = UserParty.create!(user_id: user.id, party_id: @party2.id, is_host: false)
      @u2p2 = UserParty.create!(user_id: user2.id, party_id: @party2.id, is_host: true)

      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Submit"
    end

    it "should render only the user's name", :vcr do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("#{user.name}'s Dashboard")
      expect(page).to_not have_content("#{user2.name}'s Dashboard")
    end

    it "routes me to the discover movies dashboard", :vcr do
      expect(current_path).to eq(dashboard_path)
      click_on "Discover Movies"
      expect(current_path).to eq(discover_path)
    end

    it "should render the parties the user is invited to", :vcr do
      expect(current_path).to eq(dashboard_path)

      within ".hosting_parties" do
        expect(page).to have_content(@movie1.title) #Reservoir Dogs
        expect(page).to have_content(@party1.party_date.strftime("%B %d, %Y"))
        expect(page).to have_content(@party1.party_time.strftime("%I:%M%p"))
        expect(page).to have_content("Hosting")
      end

      within ".invited_to_parties" do
        expect(page).to have_content(@movie2.title)
        expect(page).to have_content(@party2.party_date.strftime("%B %d, %Y"))
        expect(page).to have_content(@party2.party_time.strftime("%I:%M%p"))
        expect(page).to have_content("Invited")
      end
    end
  end
end
