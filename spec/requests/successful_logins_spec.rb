require 'spec_helper'

describe "SuccessfulLogins" do
  describe "Successful Login" do
    it "Visits Login page and successful login" do
    visit root_path
    click_link 'Login'
    # visit new_user_session_path
    page.has_content?('Email')
    page.has_content?('Password')
    page.has_content?('Sign in')

    fill_in "Email", :with => "test@test.gr"
    fill_in "Password", :with => "1q2w3e"
    click_button "Sign in"
    page.should have_content("test@test.gr")    
    page.should have_content("Signed in successfully.")    
    end
  end
end
