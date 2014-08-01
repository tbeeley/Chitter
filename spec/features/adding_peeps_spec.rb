require 'spec_helper'
require 'timecop'

feature "User adds a new link" do
  	
	scenario "when browsing the homepage" do
		expect(Peep.count).to eq(0)
		visit '/'
		time =  Time.now
		Timecop.freeze(time)
		add_peep("Loving this")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("Loving this")
		expect(peep.time).to eq(time)

	end

	def add_peep(message)
    	within('#new-peep') do
      		fill_in 'message', :with => message
      		click_button 'Add peep'
      	end
    end      

end