require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:flight_passengers).through(:flights)}
    it {should have_many(:passengers).through(:flight_passengers)}
  end


  describe '#adult_passengers' do
    before do
      @airline1 = Airline.create!(name: 'American Airlines')
      @airline2 = Airline.create!(name: 'United')
      @flight1 = Flight.create!(airline_id: @airline1.id, number: "1727", date: "06/05/22", departure_city: "Dallas", arrival_city: 'Chicago')
      @flight2 = Flight.create!(airline_id: @airline2.id, number: "1234", date: "2001", departure_city: "Boise", arrival_city: 'Chicago')
      @flight3 = Flight.create!(airline_id: @airline1.id, number: "0123", date: "06/05/22", departure_city: "Denver", arrival_city: 'Seattle')
      @passenger1 = Passenger.create!(name: 'Mark', age: 36)
      @passenger2 = Passenger.create!(name: 'Jane', age: 18)
      @passenger3 = Passenger.create!(name: 'Julia', age: 17)
      @passenger4 = Passenger.create!(name: 'Douglas', age: 25) 
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger3.id)
      FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger4.id)
      FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger1.id)
    end
    it 'should have a list of all adult(18 or older) passengers on a flight' do
      expect(@airline1.adult_passengers).to contain_exactly(@passenger1, @passenger2)
      expect(@airline2.adult_passengers).to contain_exactly(@passenger4)
    end

    it 'passengers should be listed by the number of flights they have taken' do
      @flight5 = Flight.create!(airline_id: @airline1.id, number: "9696", date: "06/05/22", departure_city: "Taipei", arrival_city: 'Chicago')
      @flight6 = Flight.create!(airline_id: @airline1.id, number: "1212", date: "06/07/22", departure_city: "Paris", arrival_city: 'Chicago')
      @passenger5 = Passenger.create!(name: 'Sally', age: 36)
      @passenger6 = Passenger.create!(name: 'Frankie', age: 36)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger5.id)
      FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger5.id)
      FlightPassenger.create!(flight_id: @flight5.id, passenger_id: @passenger5.id)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger6.id)
      FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger6.id)
      FlightPassenger.create!(flight_id: @flight5.id, passenger_id: @passenger6.id)
      FlightPassenger.create!(flight_id: @flight6.id, passenger_id: @passenger6.id)
      expect(@airline1.adult_passengers).to eq([@passenger6, @passenger5, @passenger1, @passenger2])
    end
  end
end
