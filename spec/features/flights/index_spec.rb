require 'rails_helper'

RSpec.describe '/flights/index', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the flights index page' do
      it 'I see a list of flight numbers' do
        @american = Airline.create!(name: 'American')
        @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @american.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")

        visit "/flights"

        expect(page).to have_content("1283")
        expect(page).to have_content("1187")
        expect(page).to have_content("1045")
      end

      it 'I see an airline name next to each flight number' do
        @american = Airline.create!(name: 'American')
        @flight1 = @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @flight2 = @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @flight3 = @american.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")
        
        visit "/flights"

        expect(page).to have_content("1283 - American")
        expect(page).to have_content("1187 - American")
        expect(page).to have_content("1045 - American")
      end

      it 'I see a list of passengers under each flight' do
        @american = Airline.create!(name: 'American')
        @flight1 = @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @flight2 = @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @flight3 = @american.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")
        @pam = Passenger.create!(name: 'Pam', age: 42)
        @bill = Passenger.create!(name: 'Bill', age: 57)
        @sue = Passenger.create!(name: 'Sue', age: 39)
        @bret = Passenger.create!(name: 'Bret', age: 27)
        @pam.passenger_flights.create!(flight: @flight1)
        @bill.passenger_flights.create!(flight: @flight1)
        @sue.passenger_flights.create!(flight: @flight2)
        @bret.passenger_flights.create!(flight: @flight3)

        visit "/flights"

        within "#flight-#{@flight1.id}" do
          expect(page).to have_content("Pam")
          expect(page).to have_content("Bill")
          expect(page).to_not have_content("Sue")
          expect(page).to_not have_content("Bret")
        end
      end
    end
  end
end