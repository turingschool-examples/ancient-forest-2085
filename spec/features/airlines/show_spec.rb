require 'rails_helper'

RSpec.describe 'Airlines Index' do
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
       
    visit airline_path(@frontier)
  end 

  describe "User Story 3" do
    context "As a visitor" do
      context "When I visit an airline's show page" do
        it "I see a list of passengers that have flights on that airline
          And I see that this list is unique (no duplicate passengers)
          And I see that this list only includes adult passenge" do
          
          expect(page).to have_content("Passenger: Diana Smith").once
          expect(page).to have_content("Age: 29").once
          expect(page).to have_content("Passenger: Andre D'lau").once
          expect(page).to have_content("Age: 41").once
          expect(page).to_not have_content("Passenger: Joe Smith")
          expect(page).to_not have_content("Age: 7")
        end
      end
    end
  end
end