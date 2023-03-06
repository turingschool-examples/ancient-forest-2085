require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it { should have_many :passenger_flights }
    it { should have_many(:passengers).through(:passenger_flights) }
  end

  describe '#instance methods' do
    describe '#passenger_names' do
      it 'returns a list of passenger names' do
    
        @american = Airline.create!(name: 'American')
        @flight1 = @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @flight2 = @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @flight3 = @american.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")
        @pam = Passenger.create!(name: 'Pam', age: 42)
        @bill = Passenger.create!(name: 'Bill', age: 57)
        @sue = Passenger.create!(name: 'Sue', age: 39)
        @bret = Passenger.create!(name: 'Bret', age: 27)
        @pam.passenger_flights.create!(flight: @flight1)
        @bill.passenger_flights.create!(flight: @flight1)
        @sue.passenger_flights.create!(flight: @flight2)
        @bret.passenger_flights.create!(flight: @flight3)


        expect(@flight1.passenger_names).to eq(["Pam", "Bill"])
      end
    end
  end
end
