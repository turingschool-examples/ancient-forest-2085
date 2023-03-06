require 'rails_helper'

RSpec.describe "Flight index page" do
  before :each do
    @Airline = Airline.create!(name: 'Turing Air')
    @flight = @Airline.flights.create!(number: "1727", date: "08/03/23", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @Airline.flights.create!(number: "2717", date: "08/03/23", departure_city: "Denver", arrival_city: "seattle")
    @passenger1 = @flight.passengers.create!(name: "Frank", age: 30)
    @passenger2 = @flight.passengers.create!(name: "Mike", age: 22)
    @passenger3 = @flight2.passengers.create!(name: "Bill", age: 25)
    @passenger4 = @flight2.passengers.create!(name: "Jeff", age: 33)
    @passenger_flight = PassengerFlight.create!(flight: @flight, passenger: @passenger1)
    @passenger_flight2 = PassengerFlight.create!(flight: @flight, passenger: @passenger2)
    @passenger_flight3 = PassengerFlight.create!(flight: @flight2, passenger: @passenger3)
    @passenger_flight4 = PassengerFlight.create!(flight: @flight2, passenger: @passenger4)
  end

  describe "As a visitor" do
    describe "When I visit the flights index page" do
      it "I see a list of all the flight numbers" do
        visit flights_path
        expect(page).to have_content("Flight Number: #{@flight.number}")
        expect(page).to have_content("Flight Number: #{@flight2.number}")
      end
      
      it " next to each flight number I see the name of the Airline of that flight " do 
        visit flights_path
        save_and_open_page

        expect(page).to have_content("Arline: #{@Airline.name}")
      end

      it "And under each flight number I see the names of all that flight's passengers" do
        visit flights_path

        expect(page).to have_content("Passengers")
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@passenger4.name)
      end 

      it "Next to each passenger I see a delete button" do
        visit flights_path
        save_and_open_page
        
        within("#passenger-#{@passenger1.id}") do
          expect(page).to have_content("Delete Passenger")
          click_button("delete Passenger")
        end
        
        expect(current_path).to eq(flights_path)
        expect(page).to not_have_content(@passenger.name)
      end
    end
  end
end