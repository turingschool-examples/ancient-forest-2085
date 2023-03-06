require  "rails_helper"
RSpec.describe "Airline Show Page" , type: :feature do
  describe "As a visitor" do

    before (:each) do
      @airline_1 = Airline.create!(name: "Frontier")
      @flight = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_1 = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Tampa")
      @jade = Passenger.create!(name: "Jade", age: 25)
      @hannah = Passenger.create!(name: "Hannah", age: 25)
      @joe = Passenger.create!(name: "Joe", age: 17)
      @joe = Passenger.create!(name: "Joe", age: 18)
      @sean = Passenger.create!(name: "Sean", age: 18)
      PassengerFlight.create!(passenger: @jade, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @hannah, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @joe, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @joe, flight: @flight, status: 0)
      PassengerFlight.create!(passenger: @sean, flight: @flight_1, status: 0)
      visit airline_path(@airline_1)
    end
    context "When I visit an airline's show page" do
      it "I see a list of unique passengers over 18 that have flights from that airline" do
        within "#airline" do
          expect(page).to have_content("Frontier")
        end
        expect(page).to have_content("Passengers over 18")
        expect(page).to have_content("Hannah Jade Joe Sean")
        expect(page).to_not have_content("Hannah Jade Joe Joe")
      end
    end
  end
end