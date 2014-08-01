require 'spec_helper'

feature 'User browses the list of peeps' do
	
	before(:each) {
		Peep.create(message: "Just doing the challenge",
					 time: Time.new)
	}

	scenario 'when opening the home page' do
		visit '/'
		expect(page).to have_content("Just doing the challenge")
	end

end