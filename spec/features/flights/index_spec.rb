require 'rails_helper'

RSpec.describe 'Flights Index feature spec' do
  before(:each) do 
  @airline1 = Airline.create!(name: "Spirit")
  @airline2 = Airline.create!(name: "Jetblue")

  @flight1 = @airline1.flights.create!(number: 23, date: "March 1, 2023", departure_city: "Mexico City", arrival_city: "Puerto Escondido") 
  
  @flight2 = @airline2.flights.create!(number: 45, date: "Jan 1, 2023", departure_city: "San Diego", arrival_city: "Los Angelas") 
  
  @passenger1 = Passenger.create!(name: "Hady", age: 33)
  @passenger2 = Passenger.create!(name: "Malena", age: 26)
  @passenger3 = Passenger.create!(name: "Axel", age: 26)
  PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
  PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
  PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)

  end 

describe "as a visitor" do 
  describe "when visit flights index" do 
    it "sees a list of all flight numbers" do 

      visit "/flights"
save_and_open_page
      within("div#flight#{@flight1.number}") do 
        expect(page).to have_content(@airline1.name)
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@flight1.number)
      end

      within("div#flight#{@flight2.number}") do 
        expect(page).to have_content(@airline2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@flight2.number)
      end



    end 
  end 
  end
 end