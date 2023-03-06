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
          
          within("##{@den.id}") do
            expect(page).to have_content("Frontier Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("Joe Smith")
            expect(page).to have_content("Diana Smith")
          end

          within("##{@hou.id}") do
            expect(page).to have_content("Frontier Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("Andre D'lau")
          end


          within("##{@nyc.id}") do
            expect(page).to have_content("Delta Airlines")
            expect(page).to have_content("Passengers:")
            expect(page).to have_content("LeVar Burton")
          end
        end
      end
    end
  end

  describe "User Story 2" do
    context "As a visitor" do
      context "When I visit the flights index page" do
        it "Next to each passengers name
          I see a link or button to remove that passenger from that flight
          When I click on that link/button I'm returned to the flights index page
          And I no longer see that passenger listed under that flight,
          And I still see the passenger listed under the other flights they were assigned to" do
          
          within("##{@den.id}") do
            expect(page).to have_button("Remove Joe Smith")
            expect(page).to have_button("Remove Diana Smith")
            
            click_button("Remove Diana Smith")
            expect(current_path).to eq(flights_path)
          end

          expect(page).to_not have_content("Diana Smith")

          within("##{@hou.id}") do
            expect(page).to have_button("Remove Andre D'lau")
          end


          within("##{@nyc.id}") do
            expect(page).to have_button("Remove LeVar Burton")
          end
        end
      end
    end
  end
end