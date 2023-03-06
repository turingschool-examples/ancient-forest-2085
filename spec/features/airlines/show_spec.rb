require 'rails_helper'

RSpec.describe 'Airlines Index feature spec' do
  before(:each) do 
  @airline1 = Airline.create!(name: "Spirit")
  @airline2 = Airline.create!(name: "Jetblue")

  @flight1 = @airline1.flights.create!(number: 23, date: "March 1, 2023", departure_city: "Mexico City", arrival_city: "Puerto Escondido") 
  @flight3 = @airline1.flights.create!(number: 86, date: "March 1, 2023", departure_city: "Beirut", arrival_city: "Jordan") 

  @flight2 = @airline2.flights.create!(number: 45, date: "Jan 1, 2023", departure_city: "San Diego", arrival_city: "Los Angelas") 
  
  @passenger1 = Passenger.create!(name: "Hady", age: 33)
  @passenger2 = Passenger.create!(name: "Malena", age: 26)
  @passenger3 = Passenger.create!(name: "Axel", age: 26)
  @passenger4 = Passenger.create!(name: "Athena", age: 4)
  @pf1 = PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
  @pf2 =PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
  @pf3 =PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)
  @pf3 =PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight3.id)
  @pf3 =PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight1.id)



  end 

  describe "as a visitor" do 
    describe "when visit airlines show page" do 
    it "has a list of all passengers with flights on that airline that are unique and only include adult passengers" do 
      visit "/airlines/#{@airline1.id}"

      expect(page).to have_selector('p', text: @passenger1.name, count: 1)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger4.name)
      expect(page).to have_content(@passenger2.name)

    end 
    end 

  end 
end 