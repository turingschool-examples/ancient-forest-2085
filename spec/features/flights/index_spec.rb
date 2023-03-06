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
  @pf1 = PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
  @pf2 =PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
  @pf3 =PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)

  end 

describe "as a visitor" do 
  describe "when visit flights index" do 
    it "sees a list of all flight numbers, airline name, and the passengers on that flight" do 

      visit "/flights"

      within("div#flight#{@flight1.number}") do 
        expect(page).to have_content(@airline1.name)
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@flight1.number)
        expect(page).to_not have_content(@passenger3.name)
      end

      within("div#flight#{@flight2.number}") do 
        expect(page).to have_content(@airline2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@flight2.number)
        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
      end

    end 

    it "next to each passenger's name, I see a link to remove that passenger from the flight" do 

    @pf4 =PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight2.id)

      visit "/flights"
      within("div#flight#{@flight1.number}") do 
        expect(page).to have_link("Delete #{@passenger1.name}", href: "/passenger_flights/#{@passenger1.id}?flight=#{@flight1.id}")

        click_on("Delete #{@passenger1.name}")

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)

      end 
    end 
  end 
  end
 end