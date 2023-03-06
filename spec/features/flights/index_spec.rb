require 'rails_helper'
RSpec.describe Flight, type: :feature do 

  describe 'Flight Index' do
    let!(:southwest) { Airline.create!(name: "SouthWest") }
    let!(:united) { Airline.create!(name: "United") }

    let!(:flight1) { southwest.flights.create!(number: 343, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }
    let!(:flight2) { southwest.flights.create!(number: 336, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }
    let!(:flight3) { southwest.flights.create!(number: 3276, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }
    let!(:flight4) { united.flights.create!(number: 5542, date: "09/04/27", departure_city: "Denver", arrival_city: "Las Vegas") }

    let!(:bob) { Passenger.create!(name: "Bob", age: 34) }
    let!(:rob) { Passenger.create!(name: "Rob", age: 9) }
    let!(:sara) { Passenger.create!(name: "Sarah", age: 29) }
    let!(:rachel) { Passenger.create!(name: "Rachel", age: 15) }
    let!(:gina) { Passenger.create!(name: "Gina", age: 36) }

    before do
      flight1.flight_passengers.create!(passenger: bob)
      flight1.flight_passengers.create!(passenger: rob)
      flight2.flight_passengers.create!(passenger: sara)
      flight3.flight_passengers.create!(passenger: rachel)
      flight4.flight_passengers.create!(passenger: gina)

      visit flights_path
    end

    describe 'As a visitor' do 
      context 'When I visit flights index' do 
        it 'I see a lis t of each flight number' do
          
        end
      end
    end
  end
end