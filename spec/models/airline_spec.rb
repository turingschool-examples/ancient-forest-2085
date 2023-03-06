require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe 'instance methods' do
    before(:each) do
      @airline_1 = Airline.create!(name: "Southwest")
      @airline_2 = Airline.create!(name: "Delta") #Control

      @flight_1 = @airline_1.flights.create!(number: "47", date: "08/03/22", departure_city: "Moscow", arrival_city: "Paris")
      @flight_2 = @airline_1.flights.create!(number: "29", date: "05/06/22", departure_city: "Rome", arrival_city: "Jerusalem")
      @flight_3 = @airline_1.flights.create!(number: "369", date: "09/03/06", departure_city: "Somewhere", arrival_city: "Nowhere") #Control

      @passenger_1 = Passenger.create!(name: "Matthew", age: 25)
      @passenger_2 = Passenger.create!(name: "Mark", age: 26)
      @passenger_3 = Passenger.create!(name: "Luke", age: 27)

      @flight_1.passengers << @passenger_1
      @flight_1.passengers << @passenger_2
      @flight_1.passengers << @passenger_3

      @flight_2.passengers << @passenger_1
      @flight_2.passengers << @passenger_2
      @flight_2.passengers << @passenger_3

      @flight_3.passengers << @passenger_1
      @flight_3.passengers << @passenger_2
      @flight_3.passengers << @passenger_3
    end

    it "can find distinct passengers" do
      expect(@airline_1.distinct_passengers).to eq([@passenger_1, @passenger_2, @passenger_3])
    end
  end
end
