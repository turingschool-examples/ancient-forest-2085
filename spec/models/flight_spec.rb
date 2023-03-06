require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end

  describe "instance methods" do

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
    end
    it "list of passengers" do
      expect(flight1.list_of_passengers).to eq(["Bob", "Joe", "Sally"])
    end
  end
end
