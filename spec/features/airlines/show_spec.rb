require 'rails_helper'

RSpec.describe 'Airline Show Page' do
  describe "As a visitor" do
    describe "When I visit /airlines/:id" do
      
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
        
        visit "/airlines/#{airline1.id}"
      end

      # User Story 3, Airline's Passengers
      
      # As a visitor
      # When I visit an airline's show page
      # Then I see a list of passengers that have flights on that airline
      # And I see that this list is unique (no duplicate passengers)
      # And I see that this list only includes adult passengers
      
      # (Note: an adult is anyone with age greater than or equal to 18)

      describe "Then I see a list of passengers that have flights on that airline" do
        describe "And I see that this list is unique (no duplicate passengers)" do
          it "And I see that this list only includes adult passengers" do
            expect(page).to have_content("Passengers:\nBob\nJoe\nSally")
          end
        end
      end
    end
  end
end
