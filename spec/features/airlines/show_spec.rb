require "rails_helper"

RSpec.describe "Airline Show Page" do
  before(:each) do
    @airline_1 = Airline.create!(name: "Southwest")
    @airline_2 = Airline.create!(name: "Delta") #Control

    @flight_1 = @airline_1.flights.create!(number: "47", date: "08/03/22", departure_city: "Moscow", arrival_city: "Paris")
    @flight_2 = @airline_1.flights.create!(number: "29", date: "05/06/22", departure_city: "Rome", arrival_city: "Jerusalem")
    @flight_3 = @airline_1.flights.create!(number: "369", date: "09/03/06", departure_city: "Somewhere", arrival_city: "Nowhere") #Control

    @passenger_1 = Passenger.create!(name: "Matthew", age: 25)
    @passenger_2 = Passenger.create!(name: "Mark", age: 26)
    @passenger_3 = Passenger.create!(name: "Luke", age: 27)
    @passenger_4 = Passenger.create!(name: "John", age: 80)
    @passenger_5 = Passenger.create!(name: "Judas", age: 666) #Control
    @passenger_6 = Passenger.create!(name: "maTHUsaLA", age: 99999) #2 flights!
    @passenger_6 = Passenger.create!(name: "maTHUsaLA", age: 99999) # duplicate passenger

    @flight_1.passengers << @passenger_1
    @flight_1.passengers << @passenger_2
    @flight_2.passengers << @passenger_3
    @flight_2.passengers << @passenger_4

    @flight_1.passengers << @passenger_6
    @flight_2.passengers << @passenger_6

    visit airline_path(@airline_1)
  end

  describe "As a visitor" do
    describe "User Story 3" do
      it "I see a list of passengers that have flights on that airline" do
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_6.name, count: 1)
      end

      it "I see that this list is unique (no duplicate passengers)" do
        
      end

      it "I see that this list only includes adult passengers" do

      end
    end
  end
end