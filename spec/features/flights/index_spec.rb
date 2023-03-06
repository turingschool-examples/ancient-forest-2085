require 'rails_helper'

RSpec.describe 'Flight index page' do 
  it 'will list all flight numbers and the name of the airline and all passengers associated with that flight' do 
    @airline1 = Airline.create!(name: "Delta")
    @airline2 = Airline.create!(name: "United")

    @flight1 = Flight.create!(number: "12345", date: "1/1/2024", departure_city: "Denver", arrival_city: "Boston", airline_id: @airline1.id)
    @flight2 = Flight.create!(number: "56789", date: "1/1/2024", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: @airline1.id)

    @flight3 = Flight.create!(number: "34567", date: "1/1/2024", departure_city: "Denver", arrival_city: "New York", airline_id: @airline2.id)
    @flight4 = Flight.create!(number: "23456", date: "1/1/2024", departure_city: "Denver", arrival_city: "Cancun", airline_id: @airline2.id)

    @passenger1 = Passenger.create(name: "Brian", age: 20)
    @passenger2 = Passenger.create(name: "John", age: 18)

    PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight2)

    PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
 

    visit '/flights'
    
    within ("#flight-#{@flight1.id}") do 

    expect(page).to have_content("flight number: #{@flight1.number}")
    expect(page).to have_content("Airline: #{@flight1.airline.name}")
    expect(page).to have_content(@passenger1.name)
    expect(page).to have_content(@passenger2.name)
    end 

    within("#flight-#{@flight2.id}") do 

    expect(page).to have_content("flight number: #{@flight2.number}")
    expect(page).to have_content("Airline: #{@flight2.airline.name}")
    expect(page).to have_content(@passenger1.name)
    end 
  end
end