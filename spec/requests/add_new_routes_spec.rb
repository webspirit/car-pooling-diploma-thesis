describe "Add new route" do
  it "Can't add new route without being logged in" do
    visit root_path
    click_link 'Add new route'
    page.should have_content('Email')
    page.should have_content('Password')
    page.should have_content('Sign in')
  end
  
  it "Can't add new route without addresses" do
    login
    click_link 'Add new route'
    page.should have_content('From:')
    page.should have_content('Range around your departure (km):')
    page.should have_content('To:')
    page.should have_content('Range around your arrival (km):')
    page.should have_content('Select date:')
    page.should have_content('Departure Time Zone')
    page.should have_content("I'm offering a route")
    page.should have_content("I'm asking a route")
    click_button "Submit new route"
    page.should have_content("Departure lat can't be blank")
    page.should have_content("Departure lng can't be blank")
    page.should have_content("Arrival lat can't be blank")
    page.should have_content("Arrival lng can't be blank")
  end
 
  it "Login, add new route successfully", :js => true do
    login
    click_link 'Add new route'
    page.should have_content('From:')
    fill_in "route_departure_address", :with => "sotiros dios 30, piraues, greece"
    page.should have_content('Range around your departure (km):')
    fill_in 'route_departure_range', :with => "2"
    page.should have_content('To:')
    fill_in 'route_arrival_address', :with => "driva 4, piraeus, greece"
    page.should have_content('Range around your arrival (km):')
    fill_in 'route_arrival_range', :with => "1"
    page.should have_content('Select date:')
    fill_in "route[date]", :with => "10-6-2012"
    page.should have_content('Departure Time Zone')
    fill_in "route[time_range_from]", :with => "17:20"
    page.should have_content("I'm offering a route")
    fill_in "route[time_range_to]", :with => "22:20"
    choose("I'm offering a route")    
    click_button "submitNewRoute"
    page.should have_content("Route was successfully created.")
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