require "rails_helper"

RSpec.describe "/", type: :feature do
  describe "when a user visits root path" do
    it "should be the landing page with the title of the app" do
      visit root_path
      expect(page).to have_content("Viewing Party")
    end

    it "I see a link to take me back to the welcome page" do
      visit root_path

      click_on "Home"

      expect(current_path).to eq(root_path)
    end

    it "displays a button to create a new user" do
      visit root_path

      expect(page).to have_content("Create a New User")
    end

    it "displays a button to discover movies" do
      visit root_path
      expect(page).to have_content("Discover Movies")
    end

    it "sad path, visitors cannot see existing users" do
      user1 = create(:user, password: "test123", password_confirmation: "test123")
      user2 = create(:user, password: "test314", password_confirmation: "test314")
      user3 = create(:user, password: "test498", password_confirmation: "test498")

      visit root_path

      within(".users") do
        expect(page).to_not have_content("Existing Users")
        expect(page).to_not have_link(user1.email)
        expect(page).to_not have_link(user2.email)
        expect(page).to_not have_link(user3.email)
      end
    end

    it "sad path, visitors cannot visit dashboard path" do
      visit dashboard_path
      expect(page).to have_content("You must be logged in or registered to access your dashboard")
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
      expect(current_path).to eq(dashboard_path)
    end

    it "happy path, upon successful login you can see a log out button" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"
      # expect(current_path).to eq(user_path(user))
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Log Out")
      expect(page).to_not have_content("Create a New User")
      expect(page).to_not have_content("Log In")
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

    it "if user is registered and logged in, has a list of Existing Users" do
      user1 = create(:user, password: "test123", password_confirmation: "test123")
      user2 = create(:user, password: "test314", password_confirmation: "test314")
      user3 = create(:user, password: "test498", password_confirmation: "test498")

      visit login_path

      fill_in :email, with: user1.email
      fill_in :password, with: user1.password

      click_on "Submit"
      # expect(current_path).to eq(user_path(user1))
      expect(current_path).to eq(dashboard_path)


      click_on "Home"
      expect(current_path).to eq(root_path)

      within(".users") do
        expect(page).to have_content("Existing Users")
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user2.email)
        expect(page).to have_content(user3.email)
      end
    end

    it "if user is registered and logged in, they can click dashboard button from root path" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"
      # expect(current_path).to eq(user_path(user))
      expect(current_path).to eq(dashboard_path)

      click_on "Home"
      click_on "Dashboard"
      expect(current_path).to eq(dashboard_path)
    end

    it "if user is registered and logged in, they can visit '/dashboard' from root path" do
      user = create(:user, password: "testing", password_confirmation: "testing")
      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"
      # expect(current_path).to eq(user_path(user))
      expect(current_path).to eq(dashboard_path)

      click_on "Home"

      visit dashboard_path
      expect(current_path).to eq(dashboard_path)
    end
  end

  describe "logging out" do
    it "can log a user out" do
      user = create(:user, password: "testing", password_confirmation: "testing")

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"

      # expect(current_path).to eq(user_path(user))
      expect(current_path).to eq(dashboard_path)


      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content("Log Out")
      expect(page).to have_content("Create a New User")
      expect(page).to have_content("Log In")
      expect(page).to_not have_content("Existing Users")
    end
  end
end
