require 'rails_helper'

RSpec.describe "Flights Index Page" do 
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

    visit flights_path
  end

  describe 'user_story_1, when visiting flights index page' do 
    it 'has a list of all flight numbers' do 
      within(".flights_info") do 
        expect(page).to have_content(@flight_1.number)
        expect(page).to have_content(@flight_2.number)
        expect(page).to have_content(@flight_3.number)
        expect(page).to have_content(@flight_4.number)
        expect(page).to have_content(@flight_5.number)
      end
    end

    it 'has the name of the airline next to each flight number' do 
      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@airline_2.name)
        expect(page).to_not have_content(@airline_1.name)
      end

      within("#flight_#{@flight_2.id}") do 
        expect(page).to have_content(@airline_2.name)
        expect(page).to_not have_content(@airline_1.name)
      end

      within("#flight_#{@flight_3.id}") do 
        expect(page).to have_content(@airline_2.name)
        expect(page).to_not have_content(@airline_1.name)
      end

      within("#flight_#{@flight_4.id}") do 
        expect(page).to have_content(@airline_1.name)
        expect(page).to_not have_content(@airline_2.name)
      end

      within("#flight_#{@flight_5.id}") do 
        expect(page).to have_content(@airline_1.name)
        expect(page).to_not have_content(@airline_2.name)
      end
    end

    it 'has the names of the passengers under the flight' do 
      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_4.name)
      end

      within("#flight_#{@flight_2.id}") do 
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_4.name)
        expect(page).to_not have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_2.name)
      end

      within("#flight_#{@flight_3.id}") do 
        expect(page).to have_content(@passenger_4.name)
        expect(page).to_not have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_2.name)
        expect(page).to_not have_content(@passenger_1.name)
      end

      within("#flight_#{@flight_4.id}") do 
        expect(page).to have_content(@passenger_2.name)
        expect(page).to_not have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_4.name)
        expect(page).to_not have_content(@passenger_1.name)
      end

      within("#flight_#{@flight_5.id}") do 
        expect(page).to have_content(@passenger_2.name)
        expect(page).to_not have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_4.name)
        expect(page).to_not have_content(@passenger_1.name)
      end
    end

    it 'can remove a passenger from a flight' do 
      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_link("Remove #{@passenger_1.name} From Flight")
      end
    end

    it 'when clicked, returns to flight index' do 
      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@passenger_1.name)
        click_link("Remove #{@passenger_1.name} From Flight")
      end
      expect(current_path).to eq(flights_path)
    end

    it 'no longer lists the passenger on that flight, but they still show on other flights' do 
      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@passenger_1.name)
        click_link("Remove #{@passenger_1.name} From Flight")
      end
      expect(current_path).to eq(flights_path)

      within("#flight_#{@flight_1.id}") do 
        expect(page).to have_content(@passenger_4.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_1.name)
      end

      within("#flight_#{@flight_2.id}") do 
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_4.name)
        expect(page).to_not have_content(@passenger_3.name)
        expect(page).to_not have_content(@passenger_2.name)
      end
    end
  end
end