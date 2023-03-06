require 'rails_helper'

RSpec.describe '@airline.flightss Index' do
	before (:each) do
		@sky = Airline.create!(name: "Sky High")

		@one = @sky.flights.create!(number: 101, date: "01/01/2021", departure_city: "Denver", arrival_city: "New York")
		@two = @sky.flights.create!(number: 150, date: "02/01/2021", departure_city: "Portland", arrival_city: "Pittsburgh")
		
		@brad = Passenger.create!(name: "Brad", age: 34)
		@jeff = Passenger.create!(name: "Jeff", age: 35)
		@joe = Passenger.create!(name: "Joe", age: 36)
		@jim = Passenger.create!(name: "Jim", age: 37)
		@jane = Passenger.create!(name: "Jane", age: 16)	
		@john = Passenger.create!(name: "Jane", age: 16)	

		@passflight1 = PassengerFlight.create!(passenger: @brad, flight: @one)
		@passflight2 = PassengerFlight.create!(passenger: @jeff, flight: @one)
		@passflight3 = PassengerFlight.create!(passenger: @joe, flight: @two)
		@passflight4 = PassengerFlight.create!(passenger: @jim, flight: @two)
		@passflight5 = PassengerFlight.create!(passenger: @jane, flight: @two)
		@passflight6 = PassengerFlight.create!(passenger: @john, flight: @one)
		@passflight7 = PassengerFlight.create!(passenger: @brad, flight: @two)
		@passflight8 = PassengerFlight.create!(passenger: @jeff, flight: @two)
		
		visit "/airlines/#{@sky.id}"
	end

	describe "As a visitor, when I visit an airline's show page" do
		it "I see a unique list of passengers that have flights from that airline" do
			save_and_open_page
			expect(page).to have_content("Brad", count: 1)
			expect(page).to have_content("Jeff", count: 1)
			expect(page).to have_content("Joe", count: 1)
			expect(page).to have_content("Jim", count: 1)
		end
	end
end