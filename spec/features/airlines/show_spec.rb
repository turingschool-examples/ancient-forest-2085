require "rails_helper"

RSpec.describe "Airlines Show Page" do
  before(:each) do
    @airline = Airline.create!(name: 'Emirates')

    @flight_1 = Flight.create!(airline: @airline, number: "1111", date: "03/06/23", departure_city: 'Denver', arrival_city: 'Charlotte')
    @flight_2 = Flight.create!(airline: @airline, number: "2222", date: "03/07/23", departure_city: 'Charlotte', arrival_city: 'Denver')
    @flight_3 = Flight.create!(airline: @airline, number: "3333", date: "03/08/23", departure_city: 'Denver', arrival_city: 'Chicago')
    @flight_4 = Flight.create!(airline: @airline, number: "4444", date: "03/10/23", departure_city: 'Denver', arrival_city: 'Orlando')


    @abdul = Passenger.create!(name: "Abdul", age: 31)
    @adam = Passenger.create!(name: "Adam", age: 36)
    @chris = Passenger.create!(name: "Chris", age: 35)
    @kid = Passenger.create!(name: "Kid", age: 5)

    FlightPassenger.create!(flight: @flight_1, passenger: @adam)
    FlightPassenger.create!(flight: @flight_2, passenger: @adam)
    FlightPassenger.create!(flight: @flight_3, passenger: @adam)
    FlightPassenger.create!(flight: @flight_4, passenger: @adam)

    FlightPassenger.create!(flight: @flight_1, passenger: @abdul)
    FlightPassenger.create!(flight: @flight_2, passenger: @abdul)
    FlightPassenger.create!(flight: @flight_4, passenger: @abdul)

    FlightPassenger.create!(flight: @flight_2, passenger: @chris)
    FlightPassenger.create!(flight: @flight_3, passenger: @chris)

    FlightPassenger.create!(flight: @flight_2, passenger: @kid)
    
    visit airline_path(@airline)
  end

  context 'User Story 3' do
    describe 'As a visitor' do
      describe "When I visit an airline's show page" do
        it "I can see a unique list of only adult passengers (age >= 18) that have flights on this airline" do
          within("#airline_adult_passengers") {
            expect(page).to have_content("Abdul")
            expect(page).to have_content("Adam")
            expect(page).to have_content("Chris")
            expect(page).to_not have_content("Kid")
          }
        end
      end
    end
  end

  context 'User Story 4' do
    describe 'As a visitor' do
      describe "When I visit an airline's show page" do
        it 'can see the list of adult passengers is sorted by number of flights each passenger has taken on the airline from most to least' do
          within("#airline_adult_passengers") {
            expect("Adam").to appear_before("Abdul")
            expect("Abdul").to appear_before("Chris")
          }
        end
      end
    end
  end
end