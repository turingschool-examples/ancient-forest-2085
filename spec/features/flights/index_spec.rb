require "rails_helper"

RSpec.describe "Flights Index Page" do
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

    @flight_1.passengers << @passenger_1
    @flight_1.passengers << @passenger_2
    @flight_2.passengers << @passenger_3
    @flight_2.passengers << @passenger_4

    @flight_1.passengers << @passenger_6
    @flight_2.passengers << @passenger_6

    visit flights_path
  end

  describe "As a visitor" do
    describe "User Story 1" do
      it "I see a list of all flight numbers" do
        within "#flight_#{@flight_1.id}" do
          expect(page).to have_content("Flight Number: #{@flight_1.number}")
        end

        within "#flight_#{@flight_2.id}" do
          expect(page).to have_content("Flight Number: #{@flight_2.number}")
        end
      end

      it "And next to each flight number I see the name of the Airline of that flight" do
        within "#flight_#{@flight_1.id}" do
          expect(page).to have_content("- #{@airline_1.name}")
        end

        within "#flight_#{@flight_2.id}" do
          expect(page).to have_content("- #{@airline_1.name}")
        end

        expect(page).to_not have_content(@airline_2.name)
      end

      it "And under each flight number I see the names of all that flight's passengers" do
        within("#flight_#{@flight_1.id}") do
          expect(page).to have_content("Passengers:")
          expect(page).to have_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end

        within("#flight_#{@flight_2.id}") do
          expect(page).to have_content("Passengers:")
          expect(page).to have_content(@passenger_3.name)
          expect(page).to have_content(@passenger_4.name)
        end

        expect(page).to_not have_content(@passenger_5.name)
      end
    end
  end

  describe "User Story 2" do
    it "has a button to remove that passenger from that flight next to that passenger's name" do

      within("#passenger_#{@passenger_6.id}_flight_#{@flight_1.id}") do
        expect(page).to have_content(@passenger_6.name)
        expect(page).to have_link("Remove Passenger")
        click_link "Remove Passenger"
      end
      
      expect(current_path).to eq(flights_path)

      within("#flight_#{@flight_1.id}") do
        expect(page).to_not have_content(@passenger_6.name)
      end

      within("#flight_#{@flight_2.id}") do
        expect(page).to have_content(@passenger_6.name)
      end
    end
  end
end