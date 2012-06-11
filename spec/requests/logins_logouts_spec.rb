require 'spec_helper'

describe "Loading home page correctly" do
  it "Visits home page" do
   visit root_path 
    page.should have_content("Sign Up")
    page.should have_content("Login")
    page.should have_content("Add new route")
    page.should have_content("My routes")
  end
end

describe "Login" do
  it "Visits Login page and successful login" do
    login 
    page.should have_content("test@test.gr")   
    page.should have_content("Logout")
    page.should have_content("Signed in successfully.")   
  end
  
  it "Wrong Password, Unsuccessfull Login" do
    visit root_path 
    click_link 'Login'
    page.should have_content('Email')
    page.should have_content('Password')
    page.should have_content('Remember me')
    page.should have_content('Sign in')
    page.should have_content("Didn't receive confirmation instructions?")
    fill_in "Email", :with => "test@test.gr"
    fill_in "Password", :with => "1q2w3e4r"
    click_button "Sign in"
    page.should have_content("Login")   
    page.should have_content("Sign up")    
  end
  
   it "User doesn't exist, Unsuccessfull Login" do
    visit root_path 
    click_link 'Login'
    page.should have_content('Email')
    page.should have_content('Password')
    page.should have_content('Remember me')
    page.should have_content('Sign in')
    page.should have_content("Didn't receive confirmation instructions?")
    fill_in "Email", :with => "notauser@notauser.gr"
    fill_in "Password", :with => "1q2w3e"
    click_button "Sign in"
    page.should have_content("Login")   
    page.should have_content("Sign up")  
  end
  
end

describe "Successful Logout" do
  it "Clicks logout, while logged in" do
    login
    click_link 'Logout'
    page.should have_content("Signed out successfully.")   
    page.should have_content("Login")
  end
end


def login 
  visit root_path 
  click_link 'Login'
  page.should have_content('Email')
  page.should have_content('Password')
  page.should have_content('Remember me')
  page.should have_content('Sign in')
  page.should have_content("Didn't receive confirmation instructions?")
  fill_in "Email", :with => "test@test.gr"
  fill_in "Password", :with => "1q2w3e"
  click_button "Sign in"
  page.should have_content("test@test.gr")   
  page.should have_content("Logout")
end