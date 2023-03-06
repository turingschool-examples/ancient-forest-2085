require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:flight_passengers).through(:flights)}
    it {should have_many(:passengers).through(:flights)}
  end

  describe '#instance methods' do
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
    
    it "should have unique list of adults passenger names" do
      expect(airline1.unique_passengers).to eq(["Huy", "Joo"])
    end
  end
end
