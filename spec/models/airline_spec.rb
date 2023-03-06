require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many(:flights)}
    it {should have_many(:passengers).through(:flights)}

  end

  before(:each) do 
    @airline_1 = Airline.create!(name: "Ryanair")
    @airline_2 = Airline.create!(name: "Lufthansa")

    @flight_1 = Flight.create!(number: "123", date:"09/12/2023", departure_city: "London", arrival_city: "Warsaw", airline_id: @airline_2.id)
    @flight_2 = Flight.create!(number: "456", date:"07/24/2023", departure_city: "Berlin", arrival_city: "France", airline_id: @airline_2.id)
    @flight_3 = Flight.create!(number: "78", date:"09/30/2023", departure_city: "Hamburg", arrival_city: "Barcelona", airline_id: @airline_2.id)

    @flight_4 = Flight.create!(number: "97", date:"05/22/2023", departure_city: "Manchester", arrival_city: "Cardiff", airline_id: @airline_1.id)
    @flight_5 = Flight.create!(number: "304", date:"01/15/2023", departure_city: "Dublin", arrival_city: "Milan", airline_id: @airline_1.id)

    @passenger_1 = Passenger.create!(name: "Damon", age: 25)
    @passenger_2 = Passenger.create!(name: "Cornelius", age: 89)
    @passenger_3 = Passenger.create!(name: "Joey", age: 17)
    @passenger_4 = Passenger.create!(name: "Luisa", age: 30)

    @p_flight_1 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_1.id)
    @p_flight_2 = PassengerFlight.create!(flight_id: @flight_2.id, passenger_id: @passenger_1.id) 

    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_2.id)
    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_4.id, passenger_id: @passenger_2.id)
    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_5.id, passenger_id: @passenger_2.id)

    @p_flight_4 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_3.id)

    @p_flight_5 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_4.id)
    @p_flight_6 = PassengerFlight.create!(flight_id: @flight_2.id, passenger_id: @passenger_4.id)
    @p_flight_7 = PassengerFlight.create!(flight_id: @flight_3.id, passenger_id: @passenger_4.id)
  end

  describe '#all_adult_passengers_sorted' do 
    it 'is a list of passengers sorted by number of flights they took' do 
      expect(@airline_2.all_adult_passengers_sorted).to eq([@passenger_4, @passenger_1, @passenger_2])
    end
  end
end
