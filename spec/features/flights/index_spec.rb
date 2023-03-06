require 'rails_helper' 

RSpec.describe 'Flights Index Page', type: :feature do
  let!(:united) { Airline.create!(name: "United") }

  let!(:flight_1) { Flight.create!(number: "208", date: "08/22/2023", departure_city: "Denver", arrival_city: "Honolulu") }
  let!(:flight_2) { Flight.create!(number: "300", date: "08/22/2023", departure_city: "San Francisco", arrival_city: "Chicago") }
  
  let!(:andra) { Passenger.create!(name: "Andra", age: 29) }
  let!(:james) { Passenger.create!(name: "James", age: 30) }
  let!(:brittany) { Passenger.create!(name: "Brittany", age: 35) }
  let!(:christa) { Passenger.create!(name: "Christa", age: 40) }

  before do
    FlightPassenger.create!(flight: flight_1, passenger: andra)
    FlightPassenger.create!(flight: flight_1, passenger: james)
    FlightPassenger.create!(flight: flight_2, passenger: brittany)

    visit "/flights"
  end

  it 'I see each passengers name' do
    expect(page).to have_content("Flight Number: 208")
    expect(page).to have_content("Flight Number: 300")

  end
end