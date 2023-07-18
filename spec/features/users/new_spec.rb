require "rails_helper"

RSpec.describe "/register", type: :feature do
  describe "when a user visits register path" do
    it "should be the register page" do
      visit register_path

      expect(page).to have_content("Viewing Party")
      expect(page).to have_content("Register a New User")
    end

    it "displays a form to register a user" do
      visit register_path
      within ".register_form" do
        expect(page).to have_field("Name:")
        expect(page).to have_field("Email:")
        expect(page).to have_field("Password:")
        expect(page).to have_field("Confirm Password:")
        expect(page).to have_button("Create a New User")
      end
    end

    # Happy Path 1 - User fills in name and unique email, matching password and confirmation and submits
    # registration with authentication happy path
    it "creates a new user, when successfully completing and submitting the form" do
      visit register_path

      within ".register_form" do
        fill_in :user_name, with: "John Doe"
        fill_in :user_email, with: "johndoe@email.com"
        fill_in :user_password, with: "test"
        fill_in :user_password_confirmation, with: "test"
        click_button "Create a New User"

        new_user = User.all.last

        # expect(current_path).to eq(user_path(new_user))
        expect(current_path).to eq(dashboard_path)
        expect(new_user).to_not have_attribute(:password)
        expect(new_user.password_digest).to_not eq("test")
      end
    end

    # Sad Path 1 - both Name and Email are required.
    it "does not create a new user, when unsuccessfully completing and submitting the form" do
      visit register_path

      within ".register_form" do
        fill_in :user_email, with: "johndoe@email.com"
        fill_in :user_password, with: "test"
        fill_in :user_password_confirmation, with: "test"
        click_button "Create a New User"
      end

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end

    # Sad Path 2 - Email must be unique to data table.
    it "should not allow users to register without a unqiue email" do
      user = create(:user, password: "test", password_confirmation: "test")

      visit register_path

      within ".register_form" do
        fill_in :user_name, with: user.name
        fill_in :user_email, with: user.email
        click_button "Create a New User"
      end

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email has already been taken")
    end

    it "sad path, cannot register if password and password confirmation don't match" do
      visit register_path

      within ".register_form" do
        fill_in :user_name, with: "John Doe"
        fill_in :user_email, with: "johndoe@email.com"
        fill_in :user_password, with: "test"
        fill_in :user_password_confirmation, with: "test!!"
        click_button "Create a New User"
      end

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match")
    end
  end
end
