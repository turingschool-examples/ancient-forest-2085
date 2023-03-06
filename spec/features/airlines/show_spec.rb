require 'rails_helper'

RSpec.describe 'Airlines Show Page' do
  describe 'as a visitor to the airlines show page' do

    let!(:airline_1) {Airline.create!(name: "Frontier")}
    let!(:airline_2) {Airline.create!(name: "Southwest")}
    
    let!(:flight_1) {Flight.create!(number: "123", date: "01/01/2020", departure_city: "Denver", arrival_city: "New York", airline_id: airline_1.id)}
    let!(:flight_2) {Flight.create!(number: "456", date: "01/01/2020", departure_city: "Denver", arrival_city: "Philadelphia", airline_id: airline_1.id)}
    let!(:flight_3) {Flight.create!(number: "789", date: "01/01/2020", departure_city: "Denver", arrival_city: "Chicago", airline_id: airline_1.id)}
    
    let!(:passenger_1) {Passenger.create!(name: "Bob", age: 20)}
    let!(:passenger_2) {Passenger.create!(name: "Sally", age: 25)}
    let!(:passenger_3) {Passenger.create!(name: "Joe", age: 30)}
    let!(:passenger_4) {Passenger.create!(name: "Timmy", age: 10)}

    
    before do
      passenger_1.passenger_flights.create!(flight: flight_1)
      passenger_1.passenger_flights.create!(flight: flight_2)
      passenger_1.passenger_flights.create!(flight: flight_3)
      
      passenger_2.passenger_flights.create!(flight: flight_1)
      passenger_2.passenger_flights.create!(flight: flight_2)
      
      passenger_3.passenger_flights.create!(flight: flight_1)
      passenger_4.passenger_flights.create!(flight: flight_1)
    end
    
    it 'I see a list of all passengers that have flights on that airline(unique) and list only includes adults' do
      visit "/airlines/#{airline_1.id}"

      expect(page).to have_content("Passengers on #{airline_1.name}")
      expect(page).to have_content("Bob", count: 1)
      expect(page).to have_content("Sally", count: 1)
      expect(page).to have_content("Joe", count: 1)
      expect(page).to_not have_content("Timmy")
    end

    xit 'I see that the list of adults id sorted by the number of flights each passenger has taken on that airline from most to least' do
      visit "/airlines/#{airline_1.id}"

      expect("Bob").to appear_before("Sally")
      expect("Sally").to appear_before("Joe")
    end
  end
end