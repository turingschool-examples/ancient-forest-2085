require 'rails_helper'

RSpec.describe 'the arilines show page page' do
  before :each do
    @southwest = Airline.create!(name: 'Southwest')
    @flight1 = Flight.create!(number: 1, date: '08/03/20', departure_city: "Denver", arrival_city: 'Reno', airline: @southwest)
    @flight2 = Flight.create!(number: 2, date: '08/04/20', departure_city: "Denver", arrival_city: 'San Diego', airline: @southwest)
    @flight3 = Flight.create!(number: 3, date: '08/05/20', departure_city: "Denver", arrival_city: 'New York', airline: @southwest)
    @matt = Passenger.create!(name: 'Matt Smith', age: 10)
    @stephanie = Passenger.create!(name: 'Stephanie Smith', age: 30)
    @sunita = Passenger.create!(name: 'Sunita Smith', age: 40)
    @passflight1 = PassengerFlight.create!(passenger: @matt, flight: @flight1)
    @passflight2 = PassengerFlight.create!(passenger: @stephanie, flight: @flight2)
    @passflight3 = PassengerFlight.create!(passenger: @sunita, flight: @flight3)
    @passflight1 = PassengerFlight.create!(passenger: @matt, flight: @flight3)
  end  

    describe "When I visit an airline's show page" do
      it "Then I see a list of passengers that have flights on that airline
      And I see that this list is unique (no duplicate passengers)
      And I see that this list only includes adult passengers" do

      visit "/airlines/#{@southwest.id}"
     
      expect(page).to have_content("Stephanie Smith", count: 1)
      expect(page).to have_content("Sunita Smith", count: 1)
      end
    end
end