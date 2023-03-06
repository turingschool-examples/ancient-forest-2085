require 'rails_helper'

RSpec.describe 'Airlines Show Page' do
  describe 'As a visitor' do
    context "When I visit the airlines show" do
      before :each do
        @airline_1 = Airline.create(name: "United Airlines")

        @flight_1 = @airline_1.flights.create(number: "3767", date: "03/05/2023", departure_city: "Los Vegas", arrival_city: "Orlando")
        @flight_2 = @airline_1.flights.create(number: "7364", date: "03/04/2023", departure_city: "Missoula", arrival_city: "Denver")
        
        @passenger_1 = Passenger.create(name: "Tom", age: 18)
        @passenger_2 = Passenger.create(name: "Sarah", age: 9)
        @passenger_3 = Passenger.create(name: "Antonio", age: 29)
        @passenger_4 = Passenger.create(name: "Antonio", age: 29)

        PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight_1.id)
        PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_1.id)
        PassengerFlight.create(passenger_id: @passenger_3.id, flight_id: @flight_1.id)
        PassengerFlight.create(passenger_id: @passenger_4.id, flight_id: @flight_1.id)
        
        visit airline_path(@airline_1.id)
      end

      it 'I see a list of passengers that have flights on that airline,' do
        within("div#flight_passengers") do
          expect(page).to have_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end
      end
    end
  end
end