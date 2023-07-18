require "rails_helper"

RSpec.describe "/", type: :feature do
  describe "when a user visits root path" do
    it "should be the landing page with the title of the app" do
      visit root_path
      expect(page).to have_content("Viewing Party")
    end

    it "I see a link to take me back to the welcome page" do
      visit root_path

      click_link "Home"

      expect(current_path).to eq(root_path)
    end

    it "displays a button to create a new user" do
      visit root_path

      expect(page).to have_button("Create a New User")
    end

    it "has a list of Existing Users which links to the users dashboard" do
      user1 = create(:user, password: "test123", password_confirmation: "test123")
      user2 = create(:user, password: "test314", password_confirmation: "test314")
      user3 = create(:user, password: "test498", password_confirmation: "test498")

      visit root_path

      within(".users") do
        expect(page).to have_content("Existing Users")
        expect(page).to have_link(user1.email)
        expect(page).to have_link(user2.email)
        expect(page).to have_link(user3.email)
      end
    end
  end

  describe "logging in" do
    it "happy path, log in link routes to user dashboard upon successful login" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"
      expect(current_path).to eq(user_path(user))
    end

    it "happy path, upon successful login you can see a log out button" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"
      expect(current_path).to eq(user_path(user))

      expect(page).to have_button("Log Out")
      expect(page).to_not have_button("Create a New User")
      expect(page).to_not have_button("Log In")
    end

    it "sad path, cannot login with bad credentials" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: "test"

      click_on "Submit"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Credentials invalid")
    end
  end

  describe "logging out" do
    # As a logged in user
    # When I visit the landing page
    # I no longer see a link to Log In or Create an Account
    # But I see a link to Log Out.
    # When I click the link to Log Out
    # I'm taken to the landing page
    # And I can see that the Log Out link has changed back to a Log In link

    it "can log a user out" do
      user = create(:user, password: "testing", password_confirmation: "testing")

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"

      expect(current_path).to eq(user_path(user))

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to_not have_button("Log Out")
      expect(page).to have_button("Create a New User")
      expect(page).to have_button("Log In")
    end
  end
end
