require 'rails_helper'

RSpec.describe '/flights' do
  describe 'flighs index page' do
    describe 'As a visitor' do
      let!(:airline1) { Airline.create!(name: "Airline1")}

      let!(:flight1) { airline1.flights.create!(number: "123", date: "12/10/2023", departure_city: "Racine", arrival_city: "Denver") }

      let!(:huy) { Passenger.create!(name: "Huy", age: 36) }
      let!(:joo) { Passenger.create!(name: "Joo", age: 25) }
      
      before do
        FlightPassenger.create!(flight: flight1, passenger: joo)
        FlightPassenger.create!(flight: flight1, passenger: huy)
      end

      it 'I should see flight information' do
        visit "/flights"

        expect(page).to have_content("#{flight1.number}")
        expect(page).to have_content("#{airline1.name}")
        expect(page).to have_content("#{huy.name}")
        expect(page).to have_content("#{joo.name}")
      end

      it "I should see a link to remove that passenger" do
        visit "/flights"

        expect(page).to have_button("Remove Passenger #{huy.name}")
        click_button("Remove Passenger #{huy.name}")

        expect(current_path).to eq("/flights")
        expect(page).to have_content("#{joo.name}")
        expect(page).to_not have_content("#{huy.name}")
      end
    end
  end
end