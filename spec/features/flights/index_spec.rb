require "rails_helper"

RSpec.describe "Flights Index Page" do
  before(:each) do
    @airline = Airline.create!(name: 'Emirates')

    @flight_1 = Flight.create!(airline: @airline, number: "1111", date: "03/06/23", departure_city: 'Denver', arrival_city: 'Charlotte')
    @flight_2 = Flight.create!(airline: @airline, number: "2222", date: "03/07/23", departure_city: 'Charlotte', arrival_city: 'Denver')
    @flight_3 = Flight.create!(airline: @airline, number: "3333", date: "03/08/23", departure_city: 'Denver', arrival_city: 'Chicago')
    @flight_4 = Flight.create!(airline: @airline, number: "4444", date: "03/09/23", departure_city: 'Chicago', arrival_city: 'Denver')
    @flight_5 = Flight.create!(airline: @airline, number: "5555", date: "03/10/23", departure_city: 'Denver', arrival_city: 'Orlando')
    @flight_6 = Flight.create!(airline: @airline, number: "6666", date: "03/11/23", departure_city: 'Orlando', arrival_city: 'Denver')

    @abdul = Passenger.create!(name: "Abdul", age: 31)
    @adam = Passenger.create!(name: "Adam", age: 36)
    @chris = Passenger.create!(name: "Chris", age: 35)

    FlightPassenger.create!(flight: @flight_2, passenger: @abdul)
    FlightPassenger.create!(flight: @flight_2, passenger: @adam)
    FlightPassenger.create!(flight: @flight_2, passenger: @chris)
  end

  context 'User Story 1' do
    describe 'As a visitor' do
      describe 'When I visit the flights index page' do
        it 'can see a list of all flight numbers with the Airline name beside that and all flight passengers listed below' do
          FlightPassenger.create!(flight: @flight_5, passenger: @abdul)
          FlightPassenger.create!(flight: @flight_1, passenger: @adam)
          FlightPassenger.create!(flight: @flight_3, passenger: @chris)

          visit flights_path

          within("#flight-#{@flight_1.id}") {
            expect(page).to have_content("Flight Number: 1111 | Airline: Emirates")
            within("#passengers-#{@flight_1.id}") {
              expect(page).to have_content("Adam")
            }
          }

          within("#flight-#{@flight_2.id}") {
            expect(page).to have_content("Flight Number: 2222 | Airline: Emirates")
            within("#passengers-#{@flight_2.id}") {
              expect(page).to have_content("Abdul")
              expect(page).to have_content("Adam")
              expect(page).to have_content("Chris")
            }
          }

          within("#flight-#{@flight_3.id}") {
            expect(page).to have_content("Flight Number: 3333 | Airline: Emirates")
            within("#passengers-#{@flight_3.id}") {
              expect(page).to have_content("Chris")
            }
          }

          within("#flight-#{@flight_5.id}") {
            expect(page).to have_content("Flight Number: 5555 | Airline: Emirates")
            within("#passengers-#{@flight_5.id}") {
              expect(page).to have_content("Abdul")
            }
          }
        end
      end
    end
  end
end