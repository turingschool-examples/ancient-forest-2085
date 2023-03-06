require "rails_helper"

RSpec.describe "Airline Show Page" do
  before(:each) do
    @airline_1 = Airline.create!(name: "Southwest")
    @airline_2 = Airline.create!(name: "Delta") #Control

    @flight_1 = @airline_1.flights.create!(number: "47", date: "08/03/22", departure_city: "Moscow", arrival_city: "Paris")
    @flight_2 = @airline_1.flights.create!(number: "29", date: "05/06/22", departure_city: "Rome", arrival_city: "Jerusalem")
    @flight_3 = @airline_2.flights.create!(number: "369", date: "09/03/06", departure_city: "Somewhere", arrival_city: "Nowhere") #Control

    @passenger_1 = Passenger.create!(name: "Matthew", age: 25)
    @passenger_2 = Passenger.create!(name: "Mark", age: 26)
    @passenger_3 = Passenger.create!(name: "Luke", age: 27)
    @passenger_4 = Passenger.create!(name: "John", age: 80)
    @passenger_5 = Passenger.create!(name: "Judas", age: 666) #Control
    @passenger_6 = Passenger.create!(name: "maTHUsaLA", age: 99999) #2 flights!
    @passenger_7 = Passenger.create!(name: "maTHUsaLA", age: 99999) # duplicate passenger

    @passenger_8 = Passenger.create!(name: "Rack", age: 5) #children
    @passenger_9 = Passenger.create!(name: "Shack", age: 8) #children
    @passenger_10 = Passenger.create!(name: "Benny", age: 14) #children

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
      it "I see a list of DISTINCT passengers that have flights on that airline" do
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_6.name, count: 1)
      end

      it "I see that this list only includes adult passengers" do
        expect(page).to_not have_content(@passenger_8.name)
        expect(page).to_not have_content(@passenger_9.name)
        expect(page).to_not have_content(@passenger_10.name)
      end
    end

    describe "Extension" do
      xit "the list of adult passengers is sorted by the number of flights each passenger has taken" do
        #passenger_6 has 2 flights, passenger_1 has 1 flight, passenger_2 has 1 flight
        @flight_3 = @airline_1.flights.create!(number: "8", date: "08/08/88", departure_city: "Denver", arrival_city: "MARS lol")

        @flight_3.passengers << @passenger_1

        expect(@passenger_6.name).to appear_before(@passenger_1.name)
        expect(@passenger_1.name).to appear_before(@passenger_2.name)
      end
    end
  end
end