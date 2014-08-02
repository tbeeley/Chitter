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

end

feature 'User signs out' do

  before(:each) do
    User.create(email: "rupert@cinnamonhill.com",
          name: "Rupert Beeley",
          username: "rbeeley",
          password: "wilkinson",
          password_confirmation: "wilkinson")
  end

  scenario 'while being signed in' do
  sign_in('rbeeley', 'wilkinson')
    click_button "Sign out"
    expect(page).to have_content("Good bye!") 
    expect(page).not_to have_content("Welcome, Rupert Beeley")
  end

end