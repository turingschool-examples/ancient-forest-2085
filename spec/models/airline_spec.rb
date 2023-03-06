require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end
  describe 'instance methods' do
    before :each do
      @airline = Airline.create!(name: "Frontier")
      @flight_1 = @airline.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @airline.flights.create!(number: "1728", date: "08/04/20", departure_city: "Reno", arrival_city: "Denver")
      @flight_3 = @airline.flights.create!(number: "1729", date: "08/05/20", departure_city: "Denver", arrival_city: "Las Vegas")
      @flight_4 = @airline.flights.create!(number: "1730", date: "08/06/20", departure_city: "Las Vegas", arrival_city: "Denver")
      @flight_5 = @airline.flights.create!(number: "1731", date: "08/07/20", departure_city: "Denver", arrival_city: "New York")
      @flight_6 = @airline.flights.create!(number: "1732", date: "08/08/20", departure_city: "New York", arrival_city: "Cleveland")
      @passenger_1 = Passenger.create!(name: "Sally Peach", age: 25)
      @passenger_2 = Passenger.create!(name: "Tomato Jones", age: 35)
      @passenger_3 = Passenger.create!(name: "Sandy Smith", age: 45)
      @passenger_4 = Passenger.create!(name: "Sally Smith", age: 15)
      @passenger_5 = Passenger.create!(name: "Tom Smith", age: 25)
      @passenger_6 = Passenger.create!(name: "Sandy Jones", age: 3)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_4, passenger: @passenger_4)
      FlightPassenger.create!(flight: @flight_4, passenger: @passenger_5)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_5)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_6)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_4)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_4, passenger: @passenger_1)
    end
    it 'can list #unique_passengers' do
      expect(@airline.unique_passengers.sort).to eq([@passenger_1, @passenger_2, @passenger_3, @passenger_5].sort)
    end

    it 'can sort #unique_passengers by number of flights' do
      expect(@airline.passengers_sorted_by_flights).to eq([@passenger_1, @passenger_3, @passenger_2, @passenger_5])
    end
  end 
end