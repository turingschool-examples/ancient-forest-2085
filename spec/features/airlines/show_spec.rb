require 'rails_helper'

RSpec.describe 'Airlines Index' do
  before(:each) do 
    @frontier = Airline.create(name: "Frontier")
    @delta = Airline.create(name: "Delta")
    
    @den = @frontier.flights.create(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @hou = @frontier.flights.create(number: "1992", date: "07/01/20", departure_city: "Houston", arrival_city: "Tampa")
    @la = @frontier.flights.create(number: "867", date: "12/21/19", departure_city: "Los Angeles", arrival_city: "Seattle")
    @anc = @frontier.flights.create(number: "5309", date: "05/18/12", departure_city: "Ancorage", arrival_city: "Atlanta")
    @nyc = @delta.flights.create(number: "2022", date: "01/01/23", departure_city: "New York City", arrival_city: "Cleveland")
    @chi = @frontier.flights.create(number: "2008", date: "01/30/22", departure_city: "Chicago", arrival_city: "New York City")
    
    @levar = Passenger.create(name: "LeVar Burton", age: 66)
    @derrick = Passenger.create(name: "Derrick Rose", age: 34)
    @joe = Passenger.create(name: "Joe Smith", age: 7)
    @andre = Passenger.create(name: "Andre D'lau", age: 41)
    @diana = Passenger.create(name: "Diana Smith", age: 29)
    
    
    PassengerFlight.create(flight: @hou, passenger: @diana)
    PassengerFlight.create(flight: @den, passenger: @diana)
    PassengerFlight.create(flight: @la, passenger: @diana)
    PassengerFlight.create(flight: @anc, passenger: @diana)
    
    PassengerFlight.create(flight: @den, passenger: @joe)
    PassengerFlight.create(flight: @hou, passenger: @joe)
    PassengerFlight.create(flight: @la, passenger: @joe)
    
    PassengerFlight.create(flight: @hou, passenger: @andre)
    PassengerFlight.create(flight: @anc, passenger: @andre)
    
    PassengerFlight.create(flight: @nyc, passenger: @levar)
    
    PassengerFlight.create(flight: @chi, passenger: @derrick)
       
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

  describe "Extension" do
    context "As a visitor" do
      context "When I visit an airline's show page" do
        it "I see that the list of adult passengers is sorted by the number off
          flights each passenger has taken on the airline from most to least" do
    
          expect(@diana.name).to appear_before(@andre.name)
          expect(@andre.name).to appear_before(@derrick.name)
        end
      end
    end
  end
end