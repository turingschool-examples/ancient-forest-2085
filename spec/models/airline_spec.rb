require 'rails_helper'

RSpec.describe Airline, type: :model do
  let!(:airline_1) {Airline.create!(name: "Frontier")}
    let!(:airline_2) {Airline.create!(name: "Southwest")}
    
    let!(:flight_1) {Flight.create!(number: "123", date: "01/01/2020", departure_city: "Denver", arrival_city: "New York", airline_id: airline_1.id)}
    let!(:flight_2) {Flight.create!(number: "456", date: "01/01/2020", departure_city: "Denver", arrival_city: "Philadelphia", airline_id: airline_1.id)}
    # let!(:flight_3) {Flight.create!(number: "789", date: "01/01/2020", departure_city: "Denver", arrival_city: "Chicago", airline_id: airline_2.id)}
    
    let!(:passenger_1) {Passenger.create!(name: "Bob", age: 20)}
    let!(:passenger_2) {Passenger.create!(name: "Sally", age: 25)}
    let!(:passenger_3) {Passenger.create!(name: "Joe", age: 30)}
    let!(:passenger_4) {Passenger.create!(name: "Timmy", age: 10)}
    
    before do
      passenger_1.passenger_flights.create!(flight: flight_1)
      passenger_1.passenger_flights.create!(flight: flight_2)
      # passenger_1.passenger_flights.create!(flight: flight_3)
      
      passenger_2.passenger_flights.create!(flight: flight_1)
      passenger_2.passenger_flights.create!(flight: flight_2)
      
      passenger_3.passenger_flights.create!(flight: flight_1)
      passenger_4.passenger_flights.create!(flight: flight_1)
    end
    
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many :passenger_flights}
    it {should have_many :passengers}
  end

  describe 'instance methods' do
    it '#adult_passengers' do
      expect(airline_1.adult_passengers).to eq(["Bob", "Joe", "Sally"])
    end
  end
end
