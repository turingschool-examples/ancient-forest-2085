require 'rails_helper'

RSpec.describe 'the flights index page' do
  before :each do
    @southwest = Airline.create!(name: 'Southwest')
    @flight1 = Flight.create!(number: 1, date: '08/03/20', departure_city: "Denver", arrival_city: 'Reno', airline: @southwest)
    @flight2 = Flight.create!(number: 2, date: '08/04/20', departure_city: "Denver", arrival_city: 'San Diego', airline: @southwest)
    @flight3 = Flight.create!(number: 3, date: '08/05/20', departure_city: "Denver", arrival_city: 'New York', airline: @southwest)
    @matt = Passenger.create!(name: 'Matt Smith', age: 20)
    @stephanie = Passenger.create!(name: 'Stephanie Smith', age: 30)
    @sunita = Passenger.create!(name: 'Sunita Smith', age: 40)
    @passflight1 = PassengerFlight.create!(passenger: @matt, flight: @flight1)
    @passflight2 = PassengerFlight.create!(passenger: @stephanie, flight: @flight2)
    @passflight3 = PassengerFlight.create!(passenger: @sunita, flight: @flight3)
    @passflight1 = PassengerFlight.create!(passenger: @matt, flight: @flight3)
  end  

    describe "When I visit the flights index page('/flights')" do
      it "I see a list of all flight numbers and next to each flight number I see the name of the Airline of that flight and under each flight number I see the names of all that flight's passengers" do

      visit '/flights'
      
      expect(page).to have_content("Flight Number: #{@flight1.number}, Airline: #{@flight1.airline.name}")
      expect(page).to have_content("Flight Number: #{@flight2.number}, Airline: #{@flight2.airline.name}")
      expect(page).to have_content("Flight Number: #{@flight3.number}, Airline: #{@flight3.airline.name}")

      expect(page).to have_content("Matt Smith", count: 2)
      expect(page).to have_content("Stephanie Smith", count: 1)
      expect(page).to have_content("Sunita Smith", count: 1)

      within("##{@flight3.number}") do
        expect(page).to have_content("Matt Smith")
        expect(page).to have_content("Sunita Smith")
      end
    end

    it "Next to each passengers name I see a link or button to remove that passenger from that flight when I click on that link/button I'm returned to the flights index page and I no longer see that passenger listed under that flight, and I still see the passenger listed under the other flights they were assigned to" do
      visit '/flights'
      save_and_open_page
      expect(page).to have_button("Remove Matt Smith")
      expect(page).to have_button("Remove Stephanie Smith")
      expect(page).to have_button("Remove Sunita Smith")
   
      within("##{@flight3.number}") do
        click_button("Remove Matt Smith")
      end

      expect(current_path).to eq('/flights')

      within("##{@flight3.number}") do
        expect(page).to have_content("Sunita Smith")
        expect(page).to_not have_content("Matt Smith")
      end
    end
  end








end