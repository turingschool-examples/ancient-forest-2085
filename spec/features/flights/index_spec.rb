require 'rails_helper'

RSpec.describe 'Flights Index' do
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
    PassengerFlight.create(flight: @nyc, passenger: @levar)
       
    visit flights_path
  end 
  describe "User Story 1" do
    context "As a visitor" do
      context "When I visit the flights index page" do
        it "I see a list of all flight numbers
          And next to each flight number I see the name of the Airline of that flight
          And under each flight number I see the names of all that flight's passengers" do
          
          expect(page).to have_content("Flight: 1727")
          expect(page).to have_content("Flight: 1992")
          expect(page).to have_content("Flight: 2022")
          
          within("#flight-#{@den.id}") do
            expect(page).to have_content("Frontier Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("Joe Smith")
            expect(page).to have_content("Diana Smith")
          end

          within("#flight-#{@hou.id}") do
            expect(page).to have_content("Frontier Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("Andre D'lau")
          end


          within("#flight-#{@hou.id}") do
            expect(page).to have_content("Delta Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("LeVar Burton")
          end
        end
      end
    end
  end
end