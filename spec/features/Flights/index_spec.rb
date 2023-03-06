require 'rails_helper'

RSpec.describe "/flights", type: :feature do
  describe "As a visitor, when I visit the flights index page" do
    before(:each) do
      @southwest = Airline.create!(name: "Southwest Airlines")
      @turkish = Airline.create!(name: "Turkish Airlines")

      @sw_flight1 = @southwest.flights.create!(number: "55", date: "01/01/2023", departure_city: "Denver", arrival_city: "Busan")
      @sw_flight2 = @southwest.flights.create!(number: "101", date: "02/02/2023", departure_city: "Busan", arrival_city: "Istanbul")
      @tk_flight3 = @turkish.flights.create!(number: "05", date: "03/03/2023", departure_city: "Istanbul", arrival_city: "Denver")

      @mel_passenger = Passenger.create!(name: "Mel", age: 38)
      @serap_passenger = Passenger.create!(name: "Serap", age: 31)

      FlightPassenger.create!(flight: @sw_flight1 passenger: @mel_passenger)
      FlightPassenger.create!(flight: @sw_flight2 passenger: @mel_passenger)
      FlightPassenger.create!(flight: @tk_flight3 passenger: @mel_passenger)

      FlightPassenger.create!(flight: @sw_flight1 passenger: @serap_passenger)
      FlightPassenger.create!(flight: @sw_flight2 passenger: @serap_passenger)
    end

    # User Story 1
    it "I see a list of all flight numbers & next to them I see Airline name of that flight" do 

    end

    # User Story 1
    it "under each flight number I see the names of all that flight's passengers" do 
      
    end
  
  end
end