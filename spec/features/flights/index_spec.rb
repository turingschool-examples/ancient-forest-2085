require 'rails_helper'

RSpec.describe '@airline.flightss Index' do
	before (:each) do
		@sky = Airline.create!(name: "Sky High")
		@rickety = Airline.create!(name: "Rickety Airlines")

		@one = @sky.flights.create!(number: 101, date: "01/01/2021", departure_city: "Denver", arrival_city: "New York")
		@two = @sky.flights.create!(number: 150, date: "02/01/2021", departure_city: "Portland", arrival_city: "Pittsburgh")
		@three = @rickety.flights.create!(number: 200, date: "03/01/2021", departure_city: "Seattle", arrival_city: "San Francisco")
		@four = @rickety.flights.create!(number: 250, date: "04/01/2021", departure_city: "Miami", arrival_city: "Los Angeles")

		@brad = Passenger.create!(name: "Brad", age: 34)
		@jeff = Passenger.create!(name: "Jeff", age: 35)
		@joe = Passenger.create!(name: "Joe", age: 36)
		@jim = Passenger.create!(name: "Jim", age: 37)
		@jane = Passenger.create!(name: "Jane", age: 38)
		@jill = Passenger.create!(name: "Jill", age: 39)
		@jimmy = Passenger.create!(name: "Jimmy", age: 40)
		@jenny = Passenger.create!(name: "Jenny", age: 41)

		@passflight1 = PassengerFlight.create!(passenger: @brad, flight: @one)
		@passflight2 = PassengerFlight.create!(passenger: @jeff, flight: @one)
		@passflight3 = PassengerFlight.create!(passenger: @joe, flight: @two)
		@passflight4 = PassengerFlight.create!(passenger: @jim, flight: @two)
		@passflight5 = PassengerFlight.create!(passenger: @jane, flight: @three)
		@passflight6 = PassengerFlight.create!(passenger: @jill, flight: @three)
		@passflight7 = PassengerFlight.create!(passenger: @jimmy, flight: @four)
		@passflight8 = PassengerFlight.create!(passenger: @jenny, flight: @four)
		@passflight9 = PassengerFlight.create!(passenger: @brad, flight: @two)
		visit "/flights/"
	end

	describe 'As a visit, when I visit the flights index page' do
		it 'see a list of all flight numbers and next to each flight number I see the name of the Airline of that flight' do
			expect(page).to have_content("Flight Number: 101 Airline: Sky High")
			expect(page).to have_content("Flight Number: 150 Airline: Sky High")
			expect(page).to have_content("Flight Number: 200 Airline: Rickety Airlines")
			expect(page).to have_content("Flight Number: 250 Airline: Rickety Airlines")
		end

		it 'Under each flight number I see the names of all that flights passengers' do

			within "#flight_#{@one.number}" do
				expect(page).to have_content("Brad")
				expect(page).to have_content("Jeff")
			end

			within "#flight_#{@two.number}" do
				expect(page).to have_content("Joe")
				expect(page).to have_content("Jim")
			end

			within "#flight_#{@three.number}" do
				expect(page).to have_content("Jane")
				expect(page).to have_content("Jill")
			end

			within "#flight_#{@four.number}" do
				expect(page).to have_content("Jimmy")
				expect(page).to have_content("Jenny")
			end
		end

		it 'Next to each passengers name I see a link or button to remove that passenger from that flight' do
			within "#flight_#{@one.number}" do
				expect(page).to have_link("Remove Brad from flight")
				expect(page).to have_link("Remove Jeff from flight")
			end

			within "#flight_#{@two.number}" do
				expect(page).to have_link("Remove Brad from flight")
				expect(page).to have_link("Remove Joe from flight")
				expect(page).to have_link("Remove Jim from flight")
			end

			within "#flight_#{@three.number}" do
				expect(page).to have_link("Remove Jane from flight")
				expect(page).to have_link("Remove Jill from flight")
			end

			within "#flight_#{@four.number}" do
				expect(page).to have_link("Remove Jimmy from flight")
				expect(page).to have_link("Remove Jenny from flight")
			end
		end

		it 'When I click on that link/button I am returned to the flights index page And I no longer see that passenger listed under that flight' do 
			within "#flight_#{@one.number}" do
			
				click_link "Remove Brad from flight"

				expect(current_path).to eq("/flights")
				expect(page).to_not have_content("Brad")
			end

			within "#flight_#{@two.number}" do
				expect(page).to have_content("Brad")
			end
		end
	end
end
