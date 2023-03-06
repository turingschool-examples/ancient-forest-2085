require 'rails_helper'

describe 'As a visitor', type: :feature do
  before(:each) do
    @united_airlines = Airline.create!(name: "United Airlines")
    @fiji_air = Airline.create!(name: "Fiji Air")

    @paris = @united_airlines.flights.create!(number: "1345", date: "02/02/22", departure_city: "Phoenix", arrival_city: "Paris")
    @melbourne = @united_airlines.flights.create!(number: "1499", date: "06/26/14", departure_city: "Suva", arrival_city: "Melbourne")
    @suva = @fiji_air.flights.create!(number: "375", date: "06/01/14", departure_city: "Washington DC", arrival_city: "Suva")    

    @abdul = Passenger.create!(name: "Abdul", age: 22)
    @chris = Passenger.create!(name: "Chris", age: 22)
    @jamison = Passenger.create!(name: "Jamison", age: 22)
    @dani = Passenger.create!(name: "Dani", age: 22)

    FlightPassenger.create!(flight: @paris, passenger: @chris)
    FlightPassenger.create!(flight: @paris, passenger: @abdul)
    FlightPassenger.create!(flight: @melbourne, passenger: @dani)
    FlightPassenger.create!(flight: @suva, passenger: @jamison)
  end

  describe 'When I visit the flights index page' do
    it 'I see a list of all flight numbers' do
      visit flights_path

      expect(page).to have_content("Flight ##{@paris.number}")
      expect(page).to have_content("Flight ##{@melbourne.number}")
      expect(page).to have_content("Flight ##{@suva.number}")
    end

    it 'Next to each flight number I see the name of the airline of that flight' do
      visit flights_path

      within "##{@paris.number}" do
        expect(page).to have_content("Flight ##{@paris.number} - #{@paris.airline.name}")
      end

      within "##{@melbourne.number}" do
        expect(page).to have_content("Flight ##{@melbourne.number} - #{@melbourne.airline.name}")
      end

      within "##{@suva.number}" do
        expect(page).to have_content("Flight ##{@suva.number} - #{@suva.airline.name}")
      end
    end

    it "Under each flight number I see the names of all that flight's passengers" do
      visit flights_path

      within "##{@paris.number}" do
        expect(page).to have_content(@chris.name)
        expect(page).to have_content(@abdul.name)
      end

      within "##{@melbourne.number}" do
        expect(page).to have_content(@dani.name)
      end

      within "##{@suva.number}" do
        expect(page).to have_content(@jamison.name)
      end
    end

    it "Next to each passenger's name, I see a link or button to remove that passenger from the flight" do
      visit flights_path

      within "##{@paris.number}" do
        expect(page).to have_button("Remove #{@chris.name}")
        expect(page).to have_button("Remove #{@abdul.name}")
      end

      within "##{@melbourne.number}" do
        expect(page).to have_button("Remove #{@dani.name}")
      end

      within "##{@suva.number}" do
        expect(page).to have_button("Remove #{@jamison.name}")
      end
    end

    it 'When I click on that button, I am returned to the flights index page and I no longer see that passenger listed under that flight and I still see the other passengers listed under their assigned flights' do
      visit flights_path

      click_button "Remove #{@chris.name}"

      expect(current_path).to eq(flights_path)
      
      within "##{@paris.number}" do
        expect(page).to have_content(@chris.name)
        expect(page).to_not have_content(@abdul.name)
      end

      within "##{@melbourne.number}" do
        expect(page).to have_content(@dani.name)
      end

      within "##{@suva.number}" do
        expect(page).to have_content(@jamison.name)
      end
    end
  end
end