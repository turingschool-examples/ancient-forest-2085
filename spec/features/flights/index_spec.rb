require 'rails_helper' 

RSpec.describe 'Flights Index Page', type: :feature do
  let!(:united) { Airline.create!(name: "United") }
  let!(:southwest) { Airline.create!(name: "Southwest") }

  let!(:flight_1) { Flight.create!(number: "208", date: "08/22/2023", departure_city: "Denver", arrival_city: "Honolulu", airline_id: united.id) }
  let!(:flight_2) { Flight.create!(number: "300", date: "08/22/2023", departure_city: "San Francisco", arrival_city: "Chicago", airline_id: united.id) }

  let!(:flight_3) { Flight.create!(number: "178", date: "08/22/2023", departure_city: "Miami", arrival_city: "Portland", airline_id: southwest.id) }

  
  let!(:andra) { Passenger.create!(name: "Andra", age: 29) }
  let!(:james) { Passenger.create!(name: "James", age: 30) }
  let!(:brittany) { Passenger.create!(name: "Brittany", age: 35) }

  let!(:christa) { Passenger.create!(name: "Christa", age: 40) }

  before do
    FlightPassenger.create!(flight: flight_1, passenger: andra)
    FlightPassenger.create!(flight: flight_1, passenger: james)
    FlightPassenger.create!(flight: flight_2, passenger: brittany)
    FlightPassenger.create!(flight: flight_3, passenger: christa)
    visit "/flights"
  end

  it 'I see list of all flight numbers next to airline of the flight, and passengers below flight number' do
    expect(page).to have_content("Flight 208: United Airlines") 
    expect(page).to have_content("Andra")
    expect(page).to have_content("James")

    expect(page).to have_content("Flight 300: United Airlines")
    expect(page).to have_content("Brittany")


    expect(page).to have_content("Flight 178: Southwest Airlines")
    expect(page).to have_content("Christa")
  end

  it 'Next to each passengers name, I see a link or button to remove that passenger from that flight' do
    expect(page).to have_link("Delete")
  end

  it 'When I click on that link/button, I`m returned to the flights index page, And I no longer see that passenger listed under that flight, And I still see the passenger listed under the other flights they were assigned to' do
    first(:link, "Delete").click

    expect(current_path).to eq("/flights")
    expect(page).to_not have_content("Andra")
  end
end