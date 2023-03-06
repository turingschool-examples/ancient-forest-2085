require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  describe "As a visitor" do

    # User Story 1, Flights Index Page
    # And next to each flight number I see the name of the Airline of that flight
    # And under each flight number I see the names of all that flight's passengers
    describe "When I visit /flights" do

      let!(:airline1) { Airline.create!(name: "Frontier") }
      let!(:airline2) { Airline.create!(name: "Southwest") }
      let!(:flight1) { Flight.create!(number: 1727, date: "08/03/20", departure_city: "Denver", arrival_city: "Reno", airline_id: airline1.id) }
      let!(:flight2) { Flight.create!(number: 1728, date: "08/07/20", departure_city: "Denver", arrival_city: "Las Vegas", airline_id: airline2.id) }
      let!(:passenger1) { Passenger.create!(name: "Bob", age: 39) }
      let!(:passenger2) { Passenger.create!(name: "Joe", age: 28) }
      let!(:passenger3) { Passenger.create!(name: "Sally", age: 23) }
      let!(:passenger4) { Passenger.create!(name: "John", age: 41) }
      let!(:passenger5) { Passenger.create!(name: "Marsha", age: 25) }

      before do
        PassengerFlight.create!(flight: flight1, passenger: passenger1)
        PassengerFlight.create!(flight: flight1, passenger: passenger2)
        PassengerFlight.create!(flight: flight1, passenger: passenger3)
        PassengerFlight.create!(flight: flight2, passenger: passenger4)
        PassengerFlight.create!(flight: flight2, passenger: passenger5)
        
        visit "/flights"
      end

      it "I see a list of all flight numbers" do
        expect(page).to have_content("Flight Number: 1727, Name: Frontier")
        expect(page).to have_content("Passengers: Bob Joe Sally")
        expect(page).to have_content("Flight Number: 1728, Name: Southwest")
        expect(page).to have_content("Passengers: John Marsha")
      end

      # User Story 2, Remove a Passenger from a Flight

      # As a visitor
      # When I visit the flights index page
      # Next to each passengers name
      # I see a link or button to remove that passenger from that flight
      # When I click on that link/button
      # I'm returned to the flights index page
      # And I no longer see that passenger listed under that flight,
      # And I still see the passenger listed under the other flights they were assigned to

      it "Next to each passengers name, I see a link to remove them from the flight" do
        expect(page).to have_link("Delete #{passenger1.name}")
        click_on "Delete #{passenger1.name}"
        expect(current_path).to eq("/flights")
        expect(page).to_not have_link("Delete #{passenger1.name}")
      end
    end
  end
end