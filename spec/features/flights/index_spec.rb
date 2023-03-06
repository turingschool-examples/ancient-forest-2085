# User Story 1, Flights Index Page

# As a visitor
# When I visit the flights index page
# I see a list of all flight numbers
# And next to each flight number I see the name of the Airline of that flight
# And under each flight number I see the names of all that flight's passengers
require 'rails_helper'

RSpec.describe 'Flight index' do 
  before :each do 
    @airline1 = Airline.create!(name: "Frontier")

    @passenger1 = Passenger.create!(name: "Joe", age: 7)
    @passenger2 = Passenger.create!(name: "Suzy Q", age: 41)
    @passenger3 = Passenger.create!(name: "Tupac", age: 25)

    @flight1 = Flight.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno", airline_id: @airline1.id) 
    @flight2 = Flight.create!(number: "1111", date: "08/03/20", departure_city: "Tampa", arrival_city: "Las Vegas", airline_id: @airline1.id) 
    @flight3 = Flight.create!(number: "2222", date: "08/03/20", departure_city: "NYC", arrival_city: "LA", airline_id: @airline1.id) 
    @flight4 = Flight.create!(number: "3333", date: "08/03/20", departure_city: "LA", arrival_city: "NYC", airline_id: @airline1.id) 

    # @flight1.passneger1.create!(name: "Joe", age: 7) 
    # @flight2.passenger2.create!(name: "Suzy Q", age: 41) 
    # @flight3.passenger3.create!(name: "Tupac", age: 25) 

    PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)
    PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight3.id)
  end  

  describe 'user story 1' do
    it 'displays a list of all flight numbers' do
      visit flights_path
      save_and_open_page

      expect(page).to have_content("1727")
      expect(page).to have_content("1111")
      expect(page).to have_content("2222")
      expect(page).to have_content("3333")
      expect(page).to_not have_content("4444")
    end  

    it 'displays the name of the Airline of that flight next to each flight number ' do
      visit flights_path

      expect(page).to have_content("Frontier")
      expect(page).to_not have_content("Southwest")
    end  

    it 'shows the names of all that flights passengers under each flight number' do
      visit flights_path

      # expect(page).to have_content("Joe")
      # expect(page).to have_content("Suzy Q")
      expect(page).to_not have_content("Tupac")

      # expect(page).to have_content("Tupac")
      expect(page).to_not have_content("Joe")
      expect(page).to_not have_content("Suzy Q")
    end  
  end

#   User Story 2, Remove a Passenger from a Flight

# As a visitor
# When I visit the flights index page
# Next to each passengers name
# I see a link or button to remove that passenger from that flight
# When I click on that link/button
# I'm returned to the flights index page
# And I no longer see that passenger listed under that flight,
# And I still see the passenger listed under the other flights they were assigned to
  describe 'user story 2' do
    it 'has link or button to remove that passenger from that flight' do
      visit flights_path
      expect(page).to have_content("Passenger")
      # save_and_open_page
      click_button("Remove")

      expect(current_path).to eq(flights_path)
    end  
  end
end 