require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
  end

  describe 'instance methods' do
    before(:each) do
      @united_airlines = Airline.create!(name: "United Airlines")
      @fiji_air = Airline.create!(name: "Fiji Air")
  
      @paris = @united_airlines.flights.create!(number: "1345", date: "02/02/22", departure_city: "Phoenix", arrival_city: "Paris")
      @melbourne = @united_airlines.flights.create!(number: "1499", date: "06/26/14", departure_city: "Suva", arrival_city: "Melbourne")
      @suva = @fiji_air.flights.create!(number: "375", date: "06/01/14", departure_city: "Washington DC", arrival_city: "Suva")    
  
      @abdul = Passenger.create!(name: "Abdul", age: 22)
      @chris = Passenger.create!(name: "Chris", age: 14)
      @jamison = Passenger.create!(name: "Jamison", age: 22)
      @dani = Passenger.create!(name: "Dani", age: 22)
  
      FlightPassenger.create!(flight: @paris, passenger: @chris)
      FlightPassenger.create!(flight: @paris, passenger: @abdul)
      FlightPassenger.create!(flight: @melbourne, passenger: @dani)
      FlightPassenger.create!(flight: @suva, passenger: @jamison)
      FlightPassenger.create!(flight: @melbourne, passenger: @abdul)
    end

    describe '#list_passengers' do
      it 'returns a unique list of adult passenger names for an airline' do
        expect(@united_airlines.list_passengers.sort).to eq(["Abdul", "Dani"].sort)

        juliet = Passenger.create!(name: "Juliet", age: 22)
        FlightPassenger.create!(flight: @melbourne, passenger: juliet)

        expect(@united_airlines.list_passengers.sort).to eq(["Abdul", "Dani", "Juliet"].sort)
      end
    end
  end
end
