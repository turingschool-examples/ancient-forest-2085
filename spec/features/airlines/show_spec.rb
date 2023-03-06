require 'rails_helper'

RSpec.describe '/airlines/:id' do
  describe 'airlines show page' do
    describe 'When I visit the airlines show page' do
      let!(:airline1) { Airline.create!(name: "Airline1")}
      let!(:airline2) { Airline.create!(name: "Airline2")}

      let!(:flight1) { airline1.flights.create!(number: "123", date: "12/10/2023", departure_city: "Racine", arrival_city: "Denver") }
      let!(:flight2) { airline2.flights.create!(number: "2333", date: "12/10/2023", departure_city: "Kenosha", arrival_city: "Vegas") }

      let!(:huy) { Passenger.create!(name: "Huy", age: 36) }
      let!(:joo) { Passenger.create!(name: "Joo", age: 25) }
      let!(:jeff) { Passenger.create!(name: "Jeff", age: 10) }
      let!(:megan) { Passenger.create!(name: "Megan", age: 12) }
      let!(:sue) { Passenger.create!(name: "Sue", age: 30) }
      
      before do
        FlightPassenger.create!(flight: flight1, passenger: joo)
        FlightPassenger.create!(flight: flight1, passenger: huy)
        FlightPassenger.create!(flight: flight1, passenger: jeff)
        FlightPassenger.create!(flight: flight2, passenger: megan)
        FlightPassenger.create!(flight: flight2, passenger: sue)
      end

      it 'should see a list of only unique passengers that are adult for that flights' do
        visit "/airlines/#{airline1.id}"

        expect(page).to have_content("#{huy.name}")
        expect(page).to have_content("#{joo.name}")
        expect(page).to_not have_content("#{jeff.name}")
      end
    end
  end
end
