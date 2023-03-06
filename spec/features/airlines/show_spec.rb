require 'rails_helper'

describe 'As a visitor', type: :feature do
  before(:each) do
    @united_airlines = Airline.create!(name: "United Airlines")
    @fiji_air = Airline.create!(name: "Fiji Air")

    @paris = @united_airlines.flights.create!(number: "1345", date: "02/02/22", departure_city: "Phoenix", arrival_city: "Paris")
    @melbourne = @united_airlines.flights.create!(number: "1499", date: "06/26/14", departure_city: "Suva", arrival_city: "Melbourne")
    @suva = @fiji_air.flights.create!(number: "375", date: "06/01/14", departure_city: "Washington DC", arrival_city: "Suva")    

    @abdul = Passenger.create!(name: "Abdul", age: 22)
    @chris = Passenger.create!(name: "Chris", age: 14)
    @jamison = Passenger.create!(name: "Jamison", age: 22)
    @dani = Passenger.create!(name: "Dani", age: 22)

    FlightPassenger.create!(flight: @paris, passenger: @chris)
    FlightPassenger.create!(flight: @paris, passenger: @abdul)

    FlightPassenger.create!(flight: @melbourne, passenger: @dani)
    FlightPassenger.create!(flight: @melbourne, passenger: @abdul)

    FlightPassenger.create!(flight: @suva, passenger: @jamison)    
  end

  describe 'When I visit an airline show page' do
    it 'I see a unique list of adult passengers that have flights on that airline' do
      visit airline_path(@united_airlines)

      within '#passengers' do
        expect(page).to have_content(@abdul.name, count: 1) #Abdul appears once, even though he is on 2 flights
        expect(page).to have_content(@dani.name, count: 1)

        expect(page).to_not have_content(@chris.name) #Chris is under the age of 18
        expect(page).to_not have_content(@jamison.name) #Jamison is on a flight from another airline
      end
    end
  end
end