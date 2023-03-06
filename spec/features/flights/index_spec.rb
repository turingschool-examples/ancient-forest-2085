require 'rails_helper'
RSpec.describe "Flights Index Page" do
  describe "As a visitor" do
    before (:each) do
      @airline_1 = Airline.create!(name: "Frontier")
      @airline_2 = Airline.create!(name: "Spirit")
      @flight_1 = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @airline_2.flights.create!(number: "1847", date: "08/03/20", departure_city: "Denver", arrival_city: "Tampa")
      @jade = Passenger.create!(name: "Jade", age: 25)
      @hannah = Passenger.create!(name: "Hannah", age: 25)
      PassengerFlight.create!(passenger: @jade, flight: @flight_1)
      PassengerFlight.create!(passenger: @hannah, flight: @flight_2)
      visit flights_path
    end
    context "When I visit the flights index page" do
      it "I see a list of all flight numbers" do
        expect(page).to have_content("Flight Number: 1727")
        expect(page).to have_content("Flight Number: 1847")
      end

      it "I see the name of the airline for each flight" do
        expect(page).to have_content("Airline: Frontier")
        expect(page).to have_content("Airline: Spirit")
      end

      it "I see the names of all passengers on each flight" do
        expect(page).to have_content("Passengers: Jade")
        expect(page).to have_content("Passengers: Hannah")
      end
    end
  end
end