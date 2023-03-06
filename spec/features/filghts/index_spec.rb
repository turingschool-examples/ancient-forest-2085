require "rails_helper"

RSpec.describe "Flights Index Page", type: :feature do
  describe "As a visitor to the flights index page" do
    let!(:airline_1) {Airline.create!(name: "Frontier")}
    let!(:airline_2) {Airline.create!(name: "Southwest")}

    let!(:flight_1) {Flight.create!(number: "123", date: "01/01/2020", departure_city: "Denver", arrival_city: "New York", airline_id: airline_1.id)}
    let!(:flight_2) {Flight.create!(number: "456", date: "01/01/2020", departure_city: "Denver", arrival_city: "Philadelphia", airline_id: airline_1.id)}
    let!(:flight_3) {Flight.create!(number: "789", date: "01/01/2020", departure_city: "Denver", arrival_city: "Chicago", airline_id: airline_2.id)}

    let!(:passenger_1) {Passenger.create!(name: "Bob", age: 20)}
    let!(:passenger_2) {Passenger.create!(name: "Sally", age: 25)}
    let!(:passenger_3) {Passenger.create!(name: "Joe", age: 30)}

    before do
      passenger_1.passenger_flights.create!(flight: flight_1)
      passenger_1.passenger_flights.create!(flight: flight_2)
      passenger_1.passenger_flights.create!(flight: flight_3)

      passenger_2.passenger_flights.create!(flight: flight_1)
      passenger_2.passenger_flights.create!(flight: flight_2)

      passenger_3.passenger_flights.create!(flight: flight_1)
    end


    it 'I see a list of all flight numbers, next to each flight #, I see the name of the airline of that flight' do
      visit '/flights'

      expect(page).to have_content("Flight number: #{flight_1.number} - Airline: #{airline_1.name}")
      expect(page).to have_content("Flight number: #{flight_2.number} - Airline: #{airline_1.name}")
      expect(page).to have_content("Flight number: #{flight_3.number} - Airline: #{airline_2.name}")

    end

    it 'Under each flight number, I see the names of all that flights passengers' do
      visit '/flights'
      expect(page).to have_content("Bob", count: 3)
      expect(page).to have_content("Sally", count: 2)
      expect(page).to have_content("Joe", count: 1)
    end

    xdescribe 'Next to each passengers name, I see a button to remove that passenger from that flight' do
      it 'when I click button, I am returned to flights index page and no longer see that passenger on that flights but they are still listed on other flights' do
        visit '/flights'

        expect(page).to have_button("Remove #{passenger_1.name} from flight #{flight_1.number}")

          click_button("Remove #{passenger_1.name} from flight #{flight_1.number}")

          expect(current_path).to eq('/flights')
          expect(page).to_not have_content("Bob", count: 2)
      end
    end
  end
end