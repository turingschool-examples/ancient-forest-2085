require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
    
    before (:each) do
      @airline_1 = Airline.create!(name: "Frontier")
      @flight = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @jade = Passenger.create!(name: "Jade", age: 25)
      @hannah = Passenger.create!(name: "Hannah", age: 25)
      @hannah_1 = Passenger.create!(name: "Hannah", age: 26)
      @joe = Passenger.create!(name: "Joe", age: 17)
      @joe = Passenger.create!(name: "Joe", age: 18)
      PassengerFlight.create!(passenger: @jade, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @hannah, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @joe, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @joe, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @hannah_1, flight: @flight, status: 0)
    end

    it "shows unique passengers over 18" do
      expect(@airline_1.unique_passengers).to eq(["Hannah", "Jade", "Joe"])
    end
  end
end
