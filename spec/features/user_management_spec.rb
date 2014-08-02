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
      expect(page).to have_content("Password does not match the confirmation")
  end

  scenario 'with an email that is already registered' do
    lambda { sign_up }.should change(User, :count).by(1)
    lambda { sign_up }.should change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
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

feature "User signs in" do

  before (:each) do
    User.create(email: "rupert@cinnamonhill.com",
          name: "Rupert Beeley",
          username: "rbeeley",
          password: "wilkinson",
          password_confirmation: "wilkinson")
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, Rupert Beeley")
    sign_in('rbeeley', 'wilkinson')
    expect(page).to have_content("Welcome, Rupert Beeley")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, Rupert Beeley")
    sign_in('rbeeley', 'notwilkinson')
    expect(page).not_to have_content("Welcome, Rupert Beeley")
  end

  def sign_in(username, password)
    visit '/sessions/new'
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end