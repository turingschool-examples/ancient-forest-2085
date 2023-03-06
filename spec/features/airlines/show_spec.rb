require 'rails_helper'

RSpec.describe 'The Airline Show Page' do
  before(:each) do
    @airline_1 = Airline.create!(name: "Frontier")

    @flight_1 = Flight.create!(number: 222, date: "02/04/22", departure_city: "Denver", arrival_city: "Chicago", airline_id: @airline_1.id)
    @flight_2 = Flight.create!(number: 223, date: "02/06/22", departure_city: "Chicago", arrival_city: "New-York", airline_id: @airline_1.id)

    @passenger_1 = Passenger.create!(name: "Dawson", age: 24)
    @passenger_2 = Passenger.create!(name: "Tim", age: 42)
    @passenger_3 = Passenger.create!(name: "Sally", age: 14)
    @passenger_4 = Passenger.create!(name: "Matt", age: 18)
    @passenger_5 = Passenger.create!(name: "Jennifer", age: 11)

    @fp_1 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @passenger_1.id)
    @fp_2 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @passenger_2.id)
    @fp_3 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @passenger_3.id)
    @fp_4 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @passenger_4.id)
    @fp_5 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @passenger_5.id)
    @fp_6 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @passenger_1.id)

    visit airline_path(@airline_1.id)
  end

  describe 'User Story 3' do
    it 'shows the visitor a list of passengers that have flights on that airline
    they see that this list is unique, and that this list only includes adult passengers' do
      within("#passengers_on_airline") {
        expect(page).to have_content("Dawson")
        expect(page).to have_content("Tim")
        expect(page).to have_content("Matt")
        expect(page).to_not have_content("Sally")
        expect(page).to_not have_content("Jennifer")
      }
    end
  end
end