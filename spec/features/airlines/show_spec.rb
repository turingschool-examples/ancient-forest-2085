require 'rails_helper'

RSpec.describe 'Airlines Show Page', type: :feature do 
  describe 'As a visitor' do
    before :each do
      @airline = Airline.create!(name: "Frontier")
      @airline_2 = Airline.create!(name: "Southwest")
      @flight_1 = @airline.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @airline.flights.create!(number: "1728", date: "08/04/20", departure_city: "Reno", arrival_city: "Denver")
      @flight_3 = @airline.flights.create!(number: "1729", date: "08/05/20", departure_city: "Denver", arrival_city: "Las Vegas")
      @flight_4 = @airline_2.flights.create!(number: "1730", date: "08/06/20", departure_city: "Las Vegas", arrival_city: "Denver")
      @flight_5 = @airline_2.flights.create!(number: "1731", date: "08/07/20", departure_city: "Denver", arrival_city: "New York")
      @flight_6 = @airline_2.flights.create!(number: "1732", date: "08/08/20", departure_city: "New York", arrival_city: "Cleveland")
      @passenger_1 = Passenger.create!(name: "Sally Peach", age: 26)
      @passenger_2 = Passenger.create!(name: "Tomato Jones", age: 35)
      @passenger_3 = Passenger.create!(name: "Sandy Smith", age: 45)
      @passenger_4 = Passenger.create!(name: "Sally Smith", age: 15)
      @passenger_5 = Passenger.create!(name: "Tom Smith", age: 25)
      @passenger_6 = Passenger.create!(name: "Sandy Jones", age: 3)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_4, passenger: @passenger_4)
      FlightPassenger.create!(flight: @flight_4, passenger: @passenger_5)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_5)
      FlightPassenger.create!(flight: @flight_5, passenger: @passenger_6)
      FlightPassenger.create!(flight: @flight_6, passenger: @passenger_4)
      FlightPassenger.create!(flight: @flight_6, passenger: @passenger_6)
      visit airline_path(@airline_2)
    end
    describe 'When I visit an airlines show page' do
      it "Then I see a list of passengers that have flights on that airline
      And I see that this list is unique (no duplicate passengers)
      And I see that this list only includes adult passengers" do
        expect(page).to have_no_content("#{@airline.name}'s Information Page")
        expect(page).to have_content("#{@airline_2.name}'s Information Page")
        within ".unique-adult-passengers" do
          expect(page).to have_content("Unique Adult Passenger Information")
          expect(page).to have_content("Name: #{@passenger_5.name}")
          expect(page).to have_content("Age: #{@passenger_5.age}")
          expect(page).to have_no_content(@passenger_4.name)
          expect(page).to have_no_content(@passenger_6.name)
          expect(page).to have_no_content(@passenger_1.name)
          expect(page).to have_no_content(@passenger_2.name)
          expect(page).to have_no_content(@passenger_3.name)
          expect(page).to have_no_content(@passenger_4.age)
          expect(page).to have_no_content(@passenger_6.age)
          expect(page).to have_no_content(@passenger_1.age)
          expect(page).to have_no_content(@passenger_2.age)
          expect(page).to have_no_content(@passenger_3.age)
        end
      end
    end
  end
end