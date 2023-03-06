require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  describe 'As a visitor' do
    before :each do
      @airline = Airline.create!(name: "Frontier")
      @flight_1 = @airline.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @airline.flights.create!(number: "1728", date: "08/04/20", departure_city: "Reno", arrival_city: "Denver")
      @flight_3 = @airline.flights.create!(number: "1729", date: "08/05/20", departure_city: "Denver", arrival_city: "Las Vegas")
      @passenger_1 = Passenger.create!(name: "Sally Peach", age: 25)
      @passenger_2 = Passenger.create!(name: "Tomato Jones", age: 35)
      @passenger_3 = Passenger.create!(name: "Sandy Smith", age: 45)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)
      visit flights_path
    end
    describe 'When I visit the flights index page' do
      it "I see a list of all flight numbers, And next to each flight number I see the name of the Airline of that flight
      And under each flight number I see the names of all that flights passengers" do
        expect(page).to have_content("Flight number:#{@flight_1.number} - #{@airline.name}")
        expect(page).to have_content("Flight number:#{@flight_2.number} - #{@airline.name}")
        expect(page).to have_content("Flight number:#{@flight_3.number} - #{@airline.name}")
        within "#flight_info-#{@flight_1.id}" do
          expect(page).to have_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end
        within "#flight_info-#{@flight_2.id}" do
          expect(page).to have_no_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end
      end
    end

    describe 'When I visit the flights index page' do
      it " I see a link or button to remove a passenger from that flight next to each passenger's name When I click on that link/buttonI'm returned to the flights index pageAnd I no longer see that passenger listed under that flight,And I still see the passenger listed under the other flights they were assigned to" do
        within "#flight_info-#{@flight_1.id}" do
        expect(page).to have_link("Remove Passenger #{@passenger_1.name}")
        click_link "Remove Passenger #{@passenger_1.name}"
          expect(page).to have_no_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end
        within "#flight_info-#{@flight_3.id}" do
          expect(page).to have_content(@passenger_1.name)
        end
      end
    end
  end
end