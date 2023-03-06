require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it { should have_many(:passenger_flights).through(:flights) }
    it { should have_many(:passengers).through(:passenger_flights) }
  end

  describe '#instance methods' do
    describe '#unique_adult_passengers' do
      it 'returns a unique list of adult passengers' do
        @american = Airline.create!(name: 'American')
        @flight1 = @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @flight2 = @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @flight3 = @american.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")
        @pam = Passenger.create!(name: 'Pam', age: 42)
        @bill = Passenger.create!(name: 'Bill', age: 57)
        @sue = Passenger.create!(name: 'Sue', age: 39)
        @bret = Passenger.create!(name: 'Bret', age: 27)
        @billy = Passenger.create!(name: 'Billy', age: 2)
        @pam.passenger_flights.create!(flight: @flight1)
        @pam.passenger_flights.create!(flight: @flight2)
        @bill.passenger_flights.create!(flight: @flight1)
        @sue.passenger_flights.create!(flight: @flight2)
        @bret.passenger_flights.create!(flight: @flight3)
        @billy.passenger_flights.create!(flight: @flight3)

        expect(@american.unique_adult_passengers).to eq(["Bill", "Bret", "Pam", "Sue"])
        expect(@american.unique_adult_passengers).to_not include(["Billy"])
      end
    end
  end
end
