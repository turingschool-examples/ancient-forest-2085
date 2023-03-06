require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:flight_passengers).through(:flights) }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  before(:each) do
    @southwest = Airline.create!(name: "Southwest Airlines")

    @sw_flight1 = @southwest.flights.create!(number: "55", date: "01/01/2023", departure_city: "Denver", arrival_city: "Busan")
    @sw_flight2 = @southwest.flights.create!(number: "101", date: "02/02/2023", departure_city: "Busan", arrival_city: "Istanbul")

    @mel_passenger = Passenger.create!(name: "Mel", age: 38)
    FlightPassenger.create!(flight: @sw_flight1, passenger: @mel_passenger)
    FlightPassenger.create!(flight: @sw_flight2, passenger: @mel_passenger)
    
    @serap_passenger = Passenger.create!(name: "Serap", age: 31)
    FlightPassenger.create!(flight: @sw_flight1, passenger: @serap_passenger)
    FlightPassenger.create!(flight: @sw_flight2, passenger: @serap_passenger)

    @serin_passenger = Passenger.create!(name: "Serin", age: 4)
    FlightPassenger.create!(flight: @sw_flight1, passenger: @serin_passenger)
  end

  describe "instance methods" do
    it "#uniq_passengers_list" do
      expect(@southwest.uniq_passengers_list).to eq([@mel_passenger, @serap_passenger, @serin_passenger])
    end
  end
end
