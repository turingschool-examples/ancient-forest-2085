require 'rails_helper'

describe 'airlines show page' do
  
  before do
    @airline1 = Airline.create!(name: 'American Airlines')
    @airline2 = Airline.create!(name: 'United')
    @flight1 = Flight.create!(airline_id: @airline1.id, number: "1727", date: "06/05/22", departure_city: "Dallas", arrival_city: 'Chicago')
    @flight2 = Flight.create!(airline_id: @airline2.id, number: "1234", date: "2001", departure_city: "Boise", arrival_city: 'Chicago')
    @passenger1 = Passenger.create!(name: 'Mark', age: 36)
    @passenger2 = Passenger.create!(name: 'Jane', age: 18)
    @passenger3 = Passenger.create!(name: 'Julia', age: 17)
    @passenger4 = Passenger.create!(name: 'Douglas', age: 25) 
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger3.id)
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger4.id)
  end

  it 'has a list of passen'
end