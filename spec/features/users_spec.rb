require 'spec_helper'

describe "user management" do

  describe "guest" do

    it "shouldn't be able to access users" do
      visit users_path
      page.current_url.should be == new_user_session_url
    end

  end

  describe "user" do
    let(:user) { FactoryGirl.create(:user) }

    it "shouldn't be able to access users" do
      login_as user
      visit users_path
      page.current_url.should be == new_user_session_url
    end

    after(:each) do
      user.destroy
    end

  end

  describe "admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:user) { FactoryGirl.create(:user) }

    it "should be able to create new user" do
      login_as(admin)
      visit users_path
      click_link 'New User'
      fill_in "Email", with: "new-user@example.com"
      fill_in "user_password", with: "my secret"
      fill_in "user_password_confirmation", with: "my secret"
      expect { click_button "Create User" }.to change(User, :count).by(1)
      User.find_by_email('new-user@example.com').destroy
    end

    it "should be able to edit user" do
      user # make sure user is saved before admin
      login_as(admin)
      visit users_path
      click_link 'Edit'
      fill_in "Email", with: "new-user@example.com"
      click_button "Update User"
      user.reload
      user.email.should be == 'new-user@example.com'
    end

    it "should be able to destroy user" do
      user # make sure user is saved before admin
      login_as(admin)
      visit users_path
      expect { click_link "Destroy" }.to change(User, :count).by(-1)
    end

    after(:each) do
      user.destroy
      admin.destroy
    end

  end

end
