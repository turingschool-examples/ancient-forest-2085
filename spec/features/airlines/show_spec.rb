require 'rails_helper'

RSpec.describe "Airline show page" do 
  it 'will have a list of all passengers that have flights on that airline that is unique and only includes adults' do 
    @airline1 = Airline.create!(name: "Delta")
    @airline2 = Airline.create!(name: "United")

    @flight1 = Flight.create!(number: "12345", date: "1/1/2024", departure_city: "Denver", arrival_city: "Boston", airline_id: @airline1.id)
    @flight2 = Flight.create!(number: "56789", date: "1/1/2024", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: @airline1.id)

    @flight3 = Flight.create!(number: "34567", date: "1/1/2024", departure_city: "Denver", arrival_city: "New York", airline_id: @airline2.id)
    @flight4 = Flight.create!(number: "23456", date: "1/1/2024", departure_city: "Denver", arrival_city: "Cancun", airline_id: @airline2.id)

    @passenger1 = Passenger.create(name: "Brian", age: 20)
    @passenger2 = Passenger.create(name: "John", age: 18)
    @passenger3 = Passenger.create(name: "Carolyn", age: 7)

    PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight2)

    PassengerFlight.create!(passenger: @passenger3, flight: @flight2)

    PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight2)

    visit "/airlines/#{@airline1.id}"
    expect(page).to have_content(@passenger1.name, count: 1)
    expect(page).to have_content(@passenger2.name, count: 1)
    expect(page).to_not have_content(@passenger3.name)
  end
end