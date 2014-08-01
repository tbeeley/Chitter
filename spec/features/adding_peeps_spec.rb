require 'spec_helper'

feature "User adds a new link" do
  	
	scenario "when browsing the homepage" do
		expect(Peep.count).to eq(0)
		visit '/'
		add_peep("Loving this", Time.new)
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("Loving this")
	end

	def add_peep(message, timestamp)
    	within('#new-peep') do
      		fill_in 'message', :with => message
      		fill_in 'timestamp', :with => timestamp
      		click_button 'Add peep'
      	end
    end      

end