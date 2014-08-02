require 'spec_helper'

feature "User signs up" do

  scenario "when being logged out" do    
      lambda { sign_up }.should change(User, :count).by(1)    
      expect(page).to have_content("Welcome, Thomas Beeley")
      expect(User.first.name).to eq("Thomas Beeley")        
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('rupert@cinnamonhill.com', 'Rupert Beeley', 'rbeeley', 'wilkinson', 'notwilkinson')}.should change(User,:count).by(0)
      expect(current_path).to eq('/users')
      expect(page).to have_content("Sorry, those passwords didn't match")
  end

  def sign_up(email = "tbeeley@gmail.com", 
              name = "Thomas Beeley",
              username = "tbeeley",
              password = "hello",
              password_confirmation = "hello"
              )
    visit '/users/new'
    expect(page.status_code).to eq(200)
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end



end