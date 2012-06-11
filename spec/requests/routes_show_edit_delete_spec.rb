describe "User's routes" do
  it "Visits My routes" do
    visit root_path
    login
    click_link 'My routes'
    page.should have_content('Show')
    page.should have_content('Edit')
    # page.should have_content('Destroy')
    page.should have_content('Departure address')
    page.should have_content('Arrival address')
    page.should have_content('Date')
  end
  
  it "Shows a route" do
    login
    click_link "My routes"
    click_link "show_route"
    page.should have_content("Departure address:")
    page.should have_content("Arrival address:")
    page.should have_content("Distance departure range:")
    page.should have_content("Distance arrival range:")
    page.should have_content("Date:")
    page.should have_content("Time range from:")
    page.should have_content("Time range to:")
    page.should have_content("Fellow Route ID:")
    page.should have_content("Find matched routes")
    page.should have_content("Edit")
  end
  
  it "finds and claims matched routes" do
    login
    click_link "My routes"
    click_link "show_route"
    click_link "Find matched routes"
    page.should have_content("Claim Route")
    page.should have_content("Departure address")
    page.should have_content("Arrival address")
    page.should have_content("Distance departure range")
    page.should have_content("Distance arrival range")
    page.should have_content("Date")
    page.should have_content("Time range from")
    page.should have_content("Time range to")
    click_link "Claimroute"
    page.should have_content("Route successfully claimed.")
  end
  
  it "edits route", :js => true do
    login
    click_link "My routes"
    click_link "edit_route"
    page.should have_content("Departure address:")
    fill_in "route_departure_address", :with => "sotiros dios 30, piraues, greece"
    page.should have_content('Range around your departure (km):')
    fill_in 'route_departure_range', :with => "2"
    page.should have_content("Arrival address:")
    fill_in 'route_arrival_address', :with => "driva 4, piraeus, greece"
    page.should have_content('Range around your arrival (km):')
    fill_in 'route_arrival_range', :with => "1"
    page.should have_content('Date:')
    fill_in "route[date]", :with => "10-6-2012"
    page.should have_content('Time range from:')
    fill_in "route[time_range_from]", :with => "17:20"
    page.should have_content("Time range to:")
    fill_in "route[time_range_to]", :with => "22:20"
    page.should have_content("Fellow Route ID:")
    choose("I'm offering a route")    
    click_button "Update route"
    page.should have_content("Route was successfully updated.")
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