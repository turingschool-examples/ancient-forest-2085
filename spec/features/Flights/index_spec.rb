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

      FlightPassenger.create!(flight: @sw_flight1, passenger: @mel_passenger)
      FlightPassenger.create!(flight: @sw_flight2, passenger: @mel_passenger)
      FlightPassenger.create!(flight: @tk_flight3, passenger: @mel_passenger)

      FlightPassenger.create!(flight: @sw_flight1, passenger: @serap_passenger)
      FlightPassenger.create!(flight: @sw_flight2, passenger: @serap_passenger)

      visit "/flights"
    end

    # User Story 1
    it "I see a list of all flight numbers & next to them I see the Airline name of that flight" do 
      expect(page).to have_content("All Flights Index Page")
      expect(page).to have_content("Flight Number: #{@sw_flight1.number}, Airline: #{@southwest.name}")
      expect(page).to have_content("Flight Number: #{@sw_flight2.number}, Airline: #{@southwest.name}")
      expect(page).to have_content("Flight Number: #{@tk_flight3.number}, Airline: #{@turkish.name}")
    end

    # User Story 1
    it "under each flight number I see the names of all that flight's passengers" do 
      within "#flight_info-#{@sw_flight1.id}" do
        expect(page).to have_content("Passengers on Flight:")
        expect(page).to have_content(@mel_passenger.name)
        expect(page).to have_content(@serap_passenger.name)
      end

      within "#flight_info-#{@tk_flight3.id}" do
        expect(page).to have_content("Passengers on Flight:")
        expect(page).to have_content(@mel_passenger.name)

        expect(page).to_not have_content(@serap_passenger.name)
      end
    end
  
    # User Story 2
    it "next to each passenger name, I see a link/button to remove that passenger from that flight" do
      within "#flight_info-#{@sw_flight1.id}" do
        expect(page).to have_button("Remove #{@mel_passenger.name}")
        expect(page).to have_button("Remove #{@serap_passenger.name}")
      end

      within "#flight_info-#{@tk_flight3.id}" do
        expect(page).to have_button("Remove #{@mel_passenger.name}")
        expect(page).to_not have_button("Remove #{@serap_passenger.name}")
      end
    end

    # User Story 2
    it "click link/button, redirected: flights index page, do NOT see passenger under THAT flight, but DO see passenger under OTHER flights" do
      within "#flight_info-#{@sw_flight1.id}" do
        expect(page).to have_content(@mel_passenger.name)
        expect(page).to have_content(@serap_passenger.name)
        click_button("Remove #{@mel_passenger.name}")
      end

      expect(current_path).to eq("/flights")

      within "#flight_info-#{@sw_flight1.id}" do
        expect(page).to have_content(@serap_passenger.name)
        expect(page).to_not have_content(@mel_passenger.name)
      end

      within "#flight_info-#{@sw_flight2.id}" do
        expect(page).to have_content(@mel_passenger.name)
      end

      within "#flight_info-#{@tk_flight3.id}" do
        expect(page).to have_content(@mel_passenger.name)
      end
    end
    
  end
end