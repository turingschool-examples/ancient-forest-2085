require 'rails_helper'

describe 'airlines show page' do
  
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
    visit airline_path(@airline1)
  end

  it 'has a list of distinct passengers over 18' do
    expect(page).to have_content "Passenger: #{@passenger1.name}, Age: #{@passenger1.age}"
    expect(page).to have_content("Passenger: #{@passenger2.name}, Age: #{@passenger2.age}", count: 1)
    expect(page).to_not have_content "Passenger: #{@passenger3.name}, Age: #{@passenger3.age}"
    expect(page).to_not have_content "Passenger: #{@passenger4.name}, Age: #{@passenger4.age}"
  end

  before do
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
    visit airline_path(@airline1)
  end

  it 'passengers are sorted by number of flights taken' do
    #Number of flights for American Airlines(Jane 1, Mark 2, Sally 3, Frankie 4)
    expect(@passenger6.name).to appear_before(@passenger5.name)
    expect(@passenger5.name).to appear_before(@passenger1.name)
    expect(@passenger1.name).to appear_before(@passenger2.name)
  end
end