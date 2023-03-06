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

      
    end
  end
end