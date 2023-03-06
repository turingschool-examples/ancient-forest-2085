require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many :passengers}
  end

  describe "Instance methods" do
    let!(:airline1) { Airline.create!(name: "SouthWest") }

    let!(:flight1) { airline1.flights.create!(number: 343, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }
    let!(:flight2) { airline1.flights.create!(number: 336, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }

    let!(:sara) { Passenger.create!(name: "Sara", age: 29) }

    before do
      @flight_passenger1 = flight1.flight_passengers.create!(passenger: sara)
      @flight_passenger2 = flight2.flight_passengers.create!(passenger: sara)
    end

    it "#find_flight_passenger" do
      expect(flight1.find_flight_passenger(sara)).to eq(@flight_passenger1)
    end
  end
end
