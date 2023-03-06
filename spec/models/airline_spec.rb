require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights) }
  end

  before :each do
    @airline_1 = Airline.create(name: "United Airlines")

    @flight_1 = @airline_1.flights.create(number: "3767", date: "03/05/2023", departure_city: "Los Vegas", arrival_city: "Orlando")
    @flight_2 = @airline_1.flights.create(number: "7364", date: "03/04/2023", departure_city: "Missoula", arrival_city: "Denver")
    
    @passenger_1 = Passenger.create(name: "Tom", age: 18)
    @passenger_2 = Passenger.create(name: "Sarah", age: 9)
    @passenger_3 = Passenger.create(name: "Antonio", age: 29)
    @passenger_4 = Passenger.create(name: "Antonio", age: 29)

    PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight_1.id)
    PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_1.id)
    PassengerFlight.create(passenger_id: @passenger_3.id, flight_id: @flight_1.id)
    PassengerFlight.create(passenger_id: @passenger_4.id, flight_id: @flight_1.id)
    
  end

  context '#adult_passengers' do
    it "returns only passengers with age greater than or equal to 18, no duplicates" do
      expect(@airline_1.adult_passengers).to eq([@passenger_1, @passenger_3])
    end
  end
end
