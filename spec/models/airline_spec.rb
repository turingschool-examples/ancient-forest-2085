require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many :flights }
    it { should have_many(:flight_passengers).through(:flights) }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  let!(:united) { Airline.create!(name: 'United Airlines') }
  let!(:southwest) { Airline.create!(name: 'Southwest Airlines') }

  let!(:flight_1) { united.flights.create!(number: "1234", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno") }
  let!(:flight_2) { united.flights.create!(number: "2345", date: "08/04/20", departure_city: "Denver", arrival_city: "Salt Lake City") }
  let!(:flight_3) { united.flights.create!(number: "3456", date: "08/05/20", departure_city: "Denver", arrival_city: "New York") }
  let!(:flight_4) { united.flights.create!(number: "4567", date: "08/06/20", departure_city: "Reno", arrival_city: "Denver") }
  let!(:flight_5) { southwest.flights.create!(number: "1233", date: "08/06/20", departure_city: "Reno", arrival_city: "Denver") }

  let!(:tom) { Passenger.create!(name: "Tom Haveford", age: 32) }
  let!(:leslie) { Passenger.create!(name: "Leslie Knope", age: 45) }
  let!(:april) { Passenger.create!(name: "April Ludgate", age: 31) }
  let!(:andy) { Passenger.create!(name: "Andy Dweyer", age: 35) }
  let!(:ron) { Passenger.create!(name: "Ron Swanson", age: 53) }
  let!(:ben) { Passenger.create!(name: "Ben Wyatt", age: 46) }
  let!(:chris) { Passenger.create!(name: "Chris Traeger", age: 54) }
  let!(:jerry) { Passenger.create!(name: "Jerry Grugich", age: 59) }
  
  let!(:kid_1) { Passenger.create!(name: "Hey Kid", age: 12) }
  let!(:kid_2) { Passenger.create!(name: "Also a Kid", age: 9) }
  let!(:teenager) { Passenger.create!(name: "I'm almost an adult", age: 17) }

  before(:each) do
    FlightPassenger.create!(flight: flight_1, passenger: tom)
    FlightPassenger.create!(flight: flight_1, passenger: april)
    FlightPassenger.create!(flight: flight_1, passenger: andy)
    FlightPassenger.create!(flight: flight_1, passenger: kid_1)
    FlightPassenger.create!(flight: flight_2, passenger: leslie)
    FlightPassenger.create!(flight: flight_2, passenger: ben)
    FlightPassenger.create!(flight: flight_2, passenger: teenager)
    FlightPassenger.create!(flight: flight_3, passenger: chris)
    FlightPassenger.create!(flight: flight_3, passenger: ron)
    FlightPassenger.create!(flight: flight_3, passenger: kid_2)
    FlightPassenger.create!(flight: flight_4, passenger: tom)
    FlightPassenger.create!(flight: flight_4, passenger: april)
    FlightPassenger.create!(flight: flight_4, passenger: andy)
    FlightPassenger.create!(flight: flight_5, passenger: jerry)
  end

  describe "#instance methods" do
    it '#unique_adult_names' do
      expect(united.unique_adult_names).to eq([andy.name, april.name, ben.name, chris.name, leslie.name, ron.name, tom.name])
      expect(united.unique_adult_names).to_not eq([andy.name, april.name, ben.name, chris.name, leslie.name, ron.name, tom.name, kid_1.name, kid_2.name, teenager.name])

      FlightPassenger.create!(flight: flight_4, passenger: jerry)

      expect(united.unique_adult_names).to eq([andy.name, april.name, ben.name, chris.name, jerry.name, leslie.name, ron.name, tom.name])
    end
  end
end
