require 'rails_helper'

RSpec.describe Passenger, type: :model do
  it { should have_many :flight_passengers }
  it { should have_many(:flights).through(:flight_passengers) }

	let!(:united) { Airline.create!(name: 'United') }
	let!(:frontier) { Airline.create!(name: 'Frontier') }
	
	let!(:flight_1) { united.flights.create!(number: 1727, date: '08/30/22', departure_city: 'Denver', arrival_city: 'Reno') }
	let!(:flight_2) { united.flights.create!(number: 1832, date: '08/30/22', departure_city: 'Los Angeles', arrival_city: 'Austin') }
	let!(:flight_3) { united.flights.create!(number: 1655, date: '08/30/22', departure_city: 'Phoenix', arrival_city: 'Las Vegas') }
	let!(:flight_4) { frontier.flights.create!(number: 1726, date: '08/30/22', departure_city: 'New York', arrival_city: 'Seattle') }
	let!(:flight_5) { frontier.flights.create!(number: 1690, date: '08/30/22', departure_city: 'Portland', arrival_city: 'San Diego') }

	let!(:passenger_1) { Passenger.create!(name: 'Joe', age: 30) }
	let!(:passenger_2) { Passenger.create!(name: 'Mary', age: 25) }
	let!(:passenger_3) { Passenger.create!(name: 'John', age: 25) }
	let!(:passenger_4) { Passenger.create!(name: 'Michael', age: 25) }
	let!(:passenger_5) { Passenger.create!(name: 'Henry', age: 25) }
	let!(:passenger_6) { Passenger.create!(name: 'David', age: 25) }
	let!(:passenger_7) { Passenger.create!(name: 'Valerie', age: 25) }

	before do
		@fp_1 = FlightPassenger.create!(flight: flight_1, passenger: passenger_1)
		@fp_2 = FlightPassenger.create!(flight: flight_2, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_2)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_3)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_5)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_6)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_7)
	end

	describe '#instance method' do
		it '#find_flight_passenger_by_flight' do
			expect(passenger_1.find_flight_passenger_by_flight(flight_1)).to eq(@fp_1)
		end
	end
end
