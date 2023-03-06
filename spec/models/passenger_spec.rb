require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
		it {should have_many :passenger_flights}
		it {should have_many(:flights).through(:passenger_flights)}
  end

	describe 'class methods' do 
		before (:each) do
			@sky = Airline.create!(name: "Sky High")
	
			@one = @sky.flights.create!(number: 101, date: "01/01/2021", departure_city: "Denver", arrival_city: "New York")
			@two = @sky.flights.create!(number: 150, date: "02/01/2021", departure_city: "Portland", arrival_city: "Pittsburgh")
		
			@brad = Passenger.create!(name: "Brad", age: 34)
			@jeff = Passenger.create!(name: "Jeff", age: 35)
			@joe = Passenger.create!(name: "Joe", age: 36)
			@john= Passenger.create!(name: "John", age: 37)
			@jimmy = Passenger.create!(name: "Jimmy", age: 16)
			@jenny = Passenger.create!(name: "Jenny", age: 16)
	
			@passflight1 = PassengerFlight.create!(passenger: @brad, flight: @one)
			@passflight2 = PassengerFlight.create!(passenger: @jeff, flight: @one)
			@passflight3 = PassengerFlight.create!(passenger: @joe, flight: @two)
			@passflight4 = PassengerFlight.create!(passenger: @john, flight: @two)
			@passflight4 = PassengerFlight.create!(passenger: @jimmy, flight: @two)
			@passflight4 = PassengerFlight.create!(passenger: @jenny, flight: @two)

		end

		it '.unique_passengers_over_18' do
			result = Passenger.unique_passengers_over_18

			expect(result.map(&:name)).to match_array(['Brad', 'Jeff', 'Joe', 'John'])
			expect(result.map(&:name)).to_not include('Jimmy', 'Jenny')
		end
	end
end