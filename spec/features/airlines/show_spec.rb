require 'rails_helper'

RSpec.describe "Airline Show Page" do 
  before(:each) do 
    @airline_1 = Airline.create!(name: "Ryanair")
    @airline_2 = Airline.create!(name: "Lufthansa")

    @flight_1 = Flight.create!(number: "123", date:"09/12/2023", departure_city: "London", arrival_city: "Warsaw", airline_id: @airline_2.id)
    @flight_2 = Flight.create!(number: "456", date:"07/24/2023", departure_city: "Berlin", arrival_city: "France", airline_id: @airline_2.id)
    @flight_3 = Flight.create!(number: "78", date:"09/30/2023", departure_city: "Hamburg", arrival_city: "Barcelona", airline_id: @airline_2.id)

    @flight_4 = Flight.create!(number: "97", date:"05/22/2023", departure_city: "Manchester", arrival_city: "Cardiff", airline_id: @airline_1.id)
    @flight_5 = Flight.create!(number: "304", date:"01/15/2023", departure_city: "Dublin", arrival_city: "Milan", airline_id: @airline_1.id)

    @passenger_1 = Passenger.create!(name: "Damon", age: 25)
    @passenger_2 = Passenger.create!(name: "Cornelius", age: 89)
    @passenger_3 = Passenger.create!(name: "Joey", age: 17)
    @passenger_4 = Passenger.create!(name: "Luisa", age: 30)

    @p_flight_1 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_1.id)
    @p_flight_2 = PassengerFlight.create!(flight_id: @flight_2.id, passenger_id: @passenger_1.id) 

    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_2.id)
    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_4.id, passenger_id: @passenger_2.id)
    @p_flight_3 = PassengerFlight.create!(flight_id: @flight_5.id, passenger_id: @passenger_2.id)

    @p_flight_4 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_3.id)

    @p_flight_5 = PassengerFlight.create!(flight_id: @flight_1.id, passenger_id: @passenger_4.id)
    @p_flight_6 = PassengerFlight.create!(flight_id: @flight_2.id, passenger_id: @passenger_4.id)
    @p_flight_7 = PassengerFlight.create!(flight_id: @flight_3.id, passenger_id: @passenger_4.id)

    visit airline_path(@airline_2)
  end

  describe 'user_story_3, when I visit an airline show page' do 
    it 'has a unique list of passengers that have flights on that airline(only adults)' do 
      within(".airline_passengers") do 
        expect(page).to have_content("Damon", count: 1)
        expect(page).to have_content("Cornelius", count: 1) 
        expect(page).to have_content("Luisa", count: 1)
        expect(page).to_not have_content("Joey") #Joey is 17
      end
    end
  end

  describe 'extension' do 
    it 'sorts the passengers by the number of flights they took on the airline, most to least' do 
      within(".frequent_flyers") do 
        expect("Luisa").to appear_before("Damon")
        expect("Damon").to appear_before("Cornelius")
        expect(page).to_not have_content("Joey")
      end

      within(".frequent_flyers") do 
        expect(page).to have_content("Luisa Flight Count: 3")
        expect(page).to have_content("Damon Flight Count: 2")
        expect(page).to have_content("Cornelius Flight Count: 1")
      end
    end
  end
end