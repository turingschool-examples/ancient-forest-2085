require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it {should have_many :passenger_flights}
    it {should have_many(:flights).through(:passenger_flights)}
  end

  describe "Class Methods" do
    before(:each) do
      @frontier = Airline.create(name: "Frontier")
      @delta = Airline.create(name: "Delta")
      
      @den = @frontier.flights.create(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @hou = @frontier.flights.create(number: "1992", date: "07/01/20", departure_city: "Houston", arrival_city: "Tampa")
      @nyc = @delta.flights.create(number: "2022", date: "01/01/23", departure_city: "New York City", arrival_city: "Cleveland")
      
      @joe = Passenger.create(name: "Joe Smith", age: 7)
      @diana = Passenger.create(name: "Diana Smith", age: 29)
      @andre = Passenger.create(name: "Andre D'lau", age: 41)
      @levar = Passenger.create(name: "LeVar Burton", age: 66)
      
      PassengerFlight.create(flight: @den, passenger: @joe)
      PassengerFlight.create(flight: @den, passenger: @diana)
      PassengerFlight.create(flight: @hou, passenger: @andre)
      PassengerFlight.create(flight: @hou, passenger: @diana)
      PassengerFlight.create(flight: @hou, passenger: @joe)
      PassengerFlight.create(flight: @nyc, passenger: @levar)
    end

    describe "#adult_passengers" do
      it "returns a unique list of all passengers 18 or older" do
        all_frontier_passengers = [@andre, @diana, @joe]
        expected_passengers = [@andre, @diana]

        expect(Passenger.adult_passengers(@frontier)).to_not match_array(all_frontier_passengers)
        expect(Passenger.adult_passengers(@frontier)).to match_array(expected_passengers)
      end
    end
  end
end