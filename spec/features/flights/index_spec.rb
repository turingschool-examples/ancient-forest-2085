require "rails_helper"

RSpec.describe "Flights Index Page" do
  before(:each) do
    @airline_1 = Airline.create!(name: "Southwest")
    @airline_2 = Airline.create!(name: "Delta") #Control

    @flight_1 = @airline_1.flights.create!(number: "47", date: "08/03/22", departure_city: "Moscow", arrival_city: "Paris")
    @flight_2 = @airline_1.flights.create!(number: "29", date: "05/06/22", departure_city: "Rome", arrival_city: "Jerusalem")
    @flight_3 = @airline_1.flights.create!(number: "369", date: "09/03/06", departure_city: "Somewhere", arrival_city: "Nowhere") #Control

    visit flights_path
  end

  describe "As a visitor" do
    describe "User Story 1" do
      it "I see a list of all flight numbers" do
        within "#flight_#{@flight_1.id}" do
          expect(page).to have_content("Flight Number: #{@flight_1.number}")
        end

        within "#flight_#{@flight_2.id}" do
          expect(page).to have_content("Flight Number: #{@flight_2.number}")
        end
      end

      it "And next to each flight number I see the name of the Airline of that flight" do
        within "#flight_#{@flight_1.id}" do
          expect(page).to have_content("- #{@airline_1.name}")
        end

        within "#flight_#{@flight_2.id}" do
        expect(page).to have_content("- #{@airline_1.name}")
        end

        expect(page).to_not have_content(@airline_2.name)
      end

      it "And under each flight number I see the names of all that flight's passengers" do

      end
    end
  end
end