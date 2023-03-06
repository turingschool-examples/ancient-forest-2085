require 'rails_helper'
RSpec.describe "Flights Index Page" do
  describe "As a visitor" do
    before (:each) do
      @airline_1 = Airline.create!(name: "Frontier")
      @airline_2 = Airline.create!(name: "Spirit")
      @flight_1 = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @airline_2.flights.create!(number: "1847", date: "08/03/20", departure_city: "Denver", arrival_city: "Tampa")
      @jade = Passenger.create!(name: "Jade", age: 25)
      @hannah = Passenger.create!(name: "Hannah", age: 25)
      PassengerFlight.create!(passenger: @jade, flight: @flight_1, status: 0)
      PassengerFlight.create!(passenger: @jade, flight: @flight_2, status: 0)
      PassengerFlight.create!(passenger: @hannah, flight: @flight_1, status: 0)
      visit flights_path
    end
    context "When I visit the flights index page" do
      it "I see a list of all flight numbers" do
        within "#flight-#{@flight_1.id}" do
          expect(page).to have_content("Flight Number: 1727")
        end
        within "#flight-#{@flight_1.id}" do
         expect(page).to have_content("Flight Number: 1847")
        end
      end

      it "I see the name of the airline for each flight" do
         within "#flight-#{@flight_1.id}" do
            expect(page).to have_content("Airline: Frontier")
         end
          within "#flight-#{@flight_2.id}" do
            expect(page).to have_content("Airline: Spirit")
          end
      end

      it "I see the names of all passengers on each flight" do
        within "#flight-#{@flight_1.id}" do 
          expect(page).to have_content("Passenger: Jade")
          expect(page).to have_content("Passenger: Hannah")
        end
        within "#flight-#{@flight_2.id}" do
          expect(page).to have_content("Passenger: Jade")
        end
      end

      it 'I see a button to remove that passenger from that flight' do
        within "#flight-#{@flight_1.id}" do
          expect(page).to have_button("Remove #{@hannah.name}")
        end
      end

      it 'When I click that button, I am returned to the flights index page and I no longer see that passenger under that flight' do
        within "#flight-#{@flight_1.id}" do
          click_button("Remove #{@hannah.name}")
          save_and_open_page
          expect(page).to have_content("Passenger: Jade")
          expect(page).to_not have_content("Passenger: Hannah")
        end
      end
    end
  end
end