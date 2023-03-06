require 'rails_helper'

RSpec.describe "/airlines/:id", type: :feature do
  describe "As a visitor, when I visit the airlines show page" do
    before(:each) do
      @southwest = Airline.create!(name: "Southwest Airlines")

      @sw_flight1 = @southwest.flights.create!(number: "55", date: "01/01/2023", departure_city: "Denver", arrival_city: "Busan")
      @sw_flight2 = @southwest.flights.create!(number: "101", date: "02/02/2023", departure_city: "Busan", arrival_city: "Istanbul")
      @sw_flight3 = @southwest.flights.create!(number: "01", date: "04/04/2023", departure_city: "Rome", arrival_city: "Paris")
      @sw_flight4 = @southwest.flights.create!(number: "99", date: "05/05/2023", departure_city: "Paris", arrival_city: "Oslo")

      @mel_passenger = Passenger.create!(name: "Mel", age: 38)
      FlightPassenger.create!(flight: @sw_flight1, passenger: @mel_passenger)
      FlightPassenger.create!(flight: @sw_flight2, passenger: @mel_passenger)
      
      @serap_passenger = Passenger.create!(name: "Serap", age: 31)
      FlightPassenger.create!(flight: @sw_flight1, passenger: @serap_passenger)
      FlightPassenger.create!(flight: @sw_flight2, passenger: @serap_passenger)
      FlightPassenger.create!(flight: @sw_flight3, passenger: @serap_passenger)
      FlightPassenger.create!(flight: @sw_flight4, passenger: @serap_passenger)

      @serin_passenger = Passenger.create!(name: "Serin", age: 4)
      FlightPassenger.create!(flight: @sw_flight1, passenger: @serin_passenger)

      @duygu_passenger = Passenger.create!(name: "Duygu", age: 29)
      FlightPassenger.create!(flight: @sw_flight1, passenger: @duygu_passenger)

      visit "/airlines/#{@southwest.id}"
    end

    #User Story 3
    it "I see a UNIQUE list of (ADULT ONLY) passengers that have flights on that airline" do
      expect(page).to have_content("#{@southwest.name} Show Page")
      expect(page).to have_content("List of all adult passengers who have flights on this airline:")
      expect(page).to have_content("#{@mel_passenger.name}", count: 1)
      expect(page).to have_content("#{@serap_passenger.name}", count: 1)
      expect(page).to have_content("#{@duygu_passenger.name}", count: 1)

      expect(page).to_not have_content("#{@serin_passenger.name}")
    end

    #Extention
    xit "the list is sorted by the number of flights each passenger has taken (most to least)" do
      expect(@serap_passenger.name).to appear_before(@mel_passenger.name)
      expect(@mel_passenger.name).to appear_before(@duygu_passenger.name)
    end

  end
end
