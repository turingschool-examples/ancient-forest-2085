require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  describe "As a visitor" do
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
        PassengerFlight.create!(flight: flight2, passenger: passenger1)
        PassengerFlight.create!(flight: flight1, passenger: passenger2)
        PassengerFlight.create!(flight: flight1, passenger: passenger3)
        PassengerFlight.create!(flight: flight2, passenger: passenger4)
        PassengerFlight.create!(flight: flight2, passenger: passenger5)
        
        visit "/flights"
      end

      # User Story 1, Flights Index Page
      it "I see a list of all flight numbers" do
        within "#flight-#{flight1.number}" do
          expect(page).to have_content("Flight Number: 1727, Name: Frontier")
          expect(page).to have_content("Bob")
          expect(page).to have_content("Joe")
          expect(page).to have_content("Sally")
          expect(page).to_not have_content("John")
          expect(page).to_not have_content("Marsha")
        end

        within "#flight-#{flight2.number}" do
          expect(page).to have_content("Flight Number: 1728, Name: Southwest")
          expect(page).to have_content("John")
          expect(page).to have_content("Marsha")
          expect(page).to have_content("Bob")
          expect(page).to_not have_content("Joe")
          expect(page).to_not have_content("Sally")
        end
      end

      # User Story 2, Remove a Passenger from a Flight
      it "Next to each passengers name, I see a link to remove them from the flight" do
        within "#flight-#{flight1.number}" do
          expect(page).to have_link("Delete #{passenger1.name} from #{flight1.number}")
          click_on "Delete #{passenger1.name}"
          expect(current_path).to eq("/flights")
          expect(page).to_not have_link("Delete #{passenger1.name}")
        end

        within "#flight-#{flight2.number}" do
          expect(page).to have_link("Delete #{passenger1.name} from #{flight2.number}")
        end
      end
    end
  end
end