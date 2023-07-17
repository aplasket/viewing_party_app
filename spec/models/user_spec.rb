require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should have_secure_password }
  end


  describe "#other_users", :vcr do
    before(:each) do
      @user1 = create(:user, password: "tests", password_confirmation: "tests")
      @user2 = create(:user, password: "tests", password_confirmation: "tests")
      @user3 = create(:user, password: "tests", password_confirmation: "tests")

      @movie1 = MovieFacade.new({id: 500}).movie
      @movie2 = MovieFacade.new({id: 400}).movie

      @party1 = create(:party, movie_id: @movie1.id)
      @party2 = create(:party, movie_id: @movie2.id)

      @user_party1 = UserParty.create!(user_id: @user1.id, party_id: @party1.id, is_host: false)
      @user_party2 = UserParty.create!(user_id: @user2.id, party_id: @party1.id, is_host: true)
      @user_party3 = UserParty.create!(user_id: @user1.id, party_id: @party2.id, is_host: true)
      @user_party4 = UserParty.create!(user_id: @user3.id, party_id: @party2.id, is_host: false)
    end

    it "returns all users except the specified user", :vcr do
      expect(User.other_users(@user1)).to_not include(@user1)
    end
  end

  describe "#invitations", :vcr do
    before(:each) do
      @user1 = create(:user, password: "tests", password_confirmation: "tests")
      @user2 = create(:user, password: "tests", password_confirmation: "tests")
      @user3 = create(:user, password: "tests", password_confirmation: "tests")

      @movie1 = MovieFacade.new({id: 500}).movie
      @movie2 = MovieFacade.new({id: 400}).movie

      @party1 = create(:party, movie_id: @movie1.id)
      @party2 = create(:party, movie_id: @movie2.id)

      @user_party1 = UserParty.create!(user_id: @user1.id, party_id: @party1.id, is_host: false)
      @user_party2 = UserParty.create!(user_id: @user2.id, party_id: @party1.id, is_host: true)
      @user_party3 = UserParty.create!(user_id: @user1.id, party_id: @party2.id, is_host: true)
      @user_party4 = UserParty.create!(user_id: @user3.id, party_id: @party2.id, is_host: false)
    end

    it "returns the parties the user is invited to", :vcr do
      expect(@user1.invitations).to include(@party1)
      expect(@user2.invitations).to eq([])
      expect(@user3.invitations).to include(@party2)
    end

    it "returns the parties the user is hosting", :vcr do
      expect(@user1.parties_hosting).to include(@party2)
      expect(@user2.parties_hosting).to include(@party1)
      expect(@user3.parties_hosting).to eq([])
    end
  end
end
