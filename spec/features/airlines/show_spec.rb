require 'rails_helper'

RSpec.describe '/airlines/:id', type: :feature do
  describe 'As a visitor' do
    describe "When I visit an airline's show page" do
      it 'I see a list of unique adult passengers with flights on the airline' do
        @american = Airline.create!(name: 'American')
        @pioneer = Airline.create!(name: 'Pioneer')
        @flight1 = @american.flights.create!(number: "1283", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Johannesburg")
        @flight2 = @american.flights.create!(number: "1187", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Hong Kong")
        @flight3 = @pioneer.flights.create!(number: "1045", date: "10/27/17", departure_city: "Bangkok", arrival_city: "Sydney")
        @pam = Passenger.create!(name: 'Pam', age: 42)
        @bill = Passenger.create!(name: 'Bill', age: 57)
        @sue = Passenger.create!(name: 'Sue', age: 39)
        @bret = Passenger.create!(name: 'Bret', age: 27)
        @billy = Passenger.create!(name: 'Billy', age: 2)
        @pam.passenger_flights.create!(flight: @flight1)
        @pam.passenger_flights.create!(flight: @flight2)
        @bill.passenger_flights.create!(flight: @flight1)
        @sue.passenger_flights.create!(flight: @flight2)
        @billy.passenger_flights.create!(flight: @flight2)
        @bret.passenger_flights.create!(flight: @flight3)

        visit airline_path(@american)

        expect(page).to have_content('Pam')
        expect(page).to have_content('Bill')
        expect(page).to have_content('Sue')
        expect(page).to_not have_content('Bret')
        expect(page).to_not have_content('Billy')
      end
    end
  end
end