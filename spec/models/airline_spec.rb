require 'rails_helper'

RSpec.describe Airline, type: :model do
  let!(:united) { Airline.create!(name: "United") }
  let!(:southwest) { Airline.create!(name: "Southwest") }

  let!(:flight_1) { Flight.create!(number: "208", date: "08/22/2023", departure_city: "Denver", arrival_city: "Honolulu", airline_id: united.id) }
  let!(:flight_2) { Flight.create!(number: "300", date: "08/22/2023", departure_city: "San Francisco", arrival_city: "Chicago", airline_id: united.id) }

  let!(:flight_3) { Flight.create!(number: "178", date: "08/22/2023", departure_city: "Miami", arrival_city: "Portland", airline_id: southwest.id) }

  
  let!(:andra) { Passenger.create!(name: "Andra", age: 29) }
  let!(:james) { Passenger.create!(name: "James", age: 30) }
  let!(:brittany) { Passenger.create!(name: "Brittany", age: 35) }
  let!(:audyn) { Passenger.create!(name: "Audyn", age: 12) }

  let!(:christa) { Passenger.create!(name: "Christa", age: 40) }

  before do
    FlightPassenger.create!(flight: flight_1, passenger: andra)
    FlightPassenger.create!(flight: flight_1, passenger: james)
    FlightPassenger.create!(flight: flight_1, passenger: brittany)

    FlightPassenger.create!(flight: flight_2, passenger: brittany)
    FlightPassenger.create!(flight: flight_2, passenger: audyn)

    FlightPassenger.create!(flight: flight_3, passenger: christa)
  end

  describe 'relationships' do
    it { should have_many :flights }
    it { should have_many(:passengers).through(:flights) }
  end

  describe 'instance methods' do
    
    it 'distinct_adult_passengers' do
      expect(united.distinct_adult_passengers).to eq([andra, james, brittany])
    end
  end
end