require 'rails_helper'

RSpec.describe 'airline show page', type: :feature do
	let!(:united) { Airline.create!(name: 'United') }
	let!(:frontier) { Airline.create!(name: 'Frontier') }
	
	let!(:flight_1) { united.flights.create!(number: 1727, date: '08/30/22', departure_city: 'Denver', arrival_city: 'Reno') }
	let!(:flight_2) { united.flights.create!(number: 1832, date: '08/30/22', departure_city: 'Los Angeles', arrival_city: 'Austin') }
	let!(:flight_3) { united.flights.create!(number: 1655, date: '08/30/22', departure_city: 'Phoenix', arrival_city: 'Las Vegas') }
	let!(:flight_4) { united.flights.create!(number: 1726, date: '08/30/22', departure_city: 'New York', arrival_city: 'Seattle') }
	let!(:flight_5) { frontier.flights.create!(number: 1690, date: '08/30/22', departure_city: 'Portland', arrival_city: 'San Diego') }

	let!(:passenger_1) { Passenger.create!(name: 'Joe', age: 30) }
	let!(:passenger_2) { Passenger.create!(name: 'Mary', age: 17) }
	let!(:passenger_3) { Passenger.create!(name: 'John', age: 25) }
	let!(:passenger_4) { Passenger.create!(name: 'Michael', age: 16) }
	let!(:passenger_5) { Passenger.create!(name: 'Henry', age: 25) }
	let!(:passenger_6) { Passenger.create!(name: 'David', age: 25) }
	let!(:passenger_7) { Passenger.create!(name: 'Valerie', age: 25) }

	before do
		FlightPassenger.create!(flight: flight_1, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_1, passenger: passenger_3)
		FlightPassenger.create!(flight: flight_1, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_1, passenger: passenger_6)

		FlightPassenger.create!(flight: flight_2, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_2)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_3)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_6)

		FlightPassenger.create!(flight: flight_3, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_3)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_5)

		FlightPassenger.create!(flight: flight_4, passenger: passenger_1)

		FlightPassenger.create!(flight: flight_5, passenger: passenger_7)

		visit airline_path(united)
	end

	describe 'shows a list of passengers that have flights on airline' do
		it 'shows unique passengers and only includes adult passengers' do
			within "#passengers" do
				expect(page).to have_content(passenger_1.name, count: 1)
				expect(page).to have_content(passenger_3.name, count: 1)
				expect(page).to have_content(passenger_5.name, count: 1)
				expect(page).to have_content(passenger_6.name, count: 1)

				expect(page).to_not have_content(passenger_4.name)
				expect(page).to_not have_content(passenger_2.name)
			end
		end
	end

	describe 'passenger list sort' do
		it 'list is sorted by number of flights each passenger has taken from most to least' do
			within "#passengers" do
				expect("#{passenger_1.name} - Flights Taken: 4").to appear_before("#{passenger_3.name} - Flights Taken: 3")
				expect("#{passenger_3.name} - Flights Taken: 3").to appear_before("#{passenger_6.name} - Flights Taken: 2")
				expect("#{passenger_6.name} - Flights Taken: 2").to appear_before("#{passenger_5.name} - Flights Taken: 1")
			end
		end
	end

end