require 'spec_helper'

feature "User signs up" do

  scenario "when being logged out" do    
      lambda { sign_up }.should change(User, :count).by(1)    
      expect(page).to have_content("Welcome, Thomas Beeley")
      expect(User.first.name).to eq("Thomas Beeley")        
  end

  def sign_up(email = "tbeeley@gmail.com", 
              name = "Thomas Beeley",
              username = "tbeeley",
              password = "hello"
              )
    visit '/users/new'
    expect(page.status_code).to eq(200)
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :password, :with => password
    click_button "Sign up"
  end

end