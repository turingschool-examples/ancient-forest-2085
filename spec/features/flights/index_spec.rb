require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  describe 'As a visitor' do
    context "When I visit the flights index" do
      before :each do
        @airline_1 = Airline.create(name: "United Airlines")

        @flight_1 = @airline_1.flights.create(number: "3767", date: "03/05/2023", departure_city: "Los Vegas", arrival_city: "Orlando")
        @flight_2 = @airline_1.flights.create(number: "7364", date: "03/04/2023", departure_city: "Missoula", arrival_city: "Denver")
        
        @passenger_1 = Passenger.create(name: "Tom", age: 65)
        @passenger_2 = Passenger.create(name: "Sarah", age: 42)
        @passenger_3 = Passenger.create(name: "Frank", age: 12)
        @passenger_4 = Passenger.create(name: "Antonio", age: 29)

        PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight_1.id)
        PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_1.id)
        PassengerFlight.create(passenger_id: @passenger_3.id, flight_id: @flight_2.id)
        PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight_2.id)
        
        visit flights_path
      end

      it 'sees a list of all flight numbers, sees the name of the Airline of that flight next to each flight number and each flights passengers ' do
        within("div#flight_details-#{@flight_1.id}") do
          expect(page).to have_content("Flight Details: #{@flight_1.airline.name} - ##{@flight_1.number}")
          expect(page).to have_content(@passenger_1.name)
          expect(page).to have_content(@passenger_2.name)
        end
        
        within("div#flight_details-#{@flight_2.id}") do
          expect(page).to have_content("Flight Details: #{@flight_2.airline.name} - ##{@flight_2.number}")
          expect(page).to have_content(@passenger_1.name)
          expect(page).to have_content(@passenger_3.name)
        end
      end

      it "I see a link or button to remove that passenger from that flight, I click it, and I'm returned to the flights index page" do
    
        within("div##{@passenger_1.id}-#{@flight_1.id}") do
          expect(page).to have_content("Tom")
          expect(page).to have_button("Delete")
          
          click_button "Delete"
        end

        expect(current_path).to eq(flights_path)
        
        within("div#flight_details-#{@flight_1.id}") do
          expect(page).to_not have_content("#{@passenger_1.name}")
        end

        within("div#flight_details-#{@flight_2.id}") do
          expect(page).to have_content("#{@passenger_1.name}")
        end
      end
    end
  end
end
