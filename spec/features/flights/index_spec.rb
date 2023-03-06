require 'rails_helper'

RSpec.describe '@airline.flightss Index' do
	before (:each) do
		@sky = Airline.create!(name: "Sky High")
		@rickety = Airline.create!(name: "Rickety Airlines")

		@one = @sky.flights.create!(number: 101, date: "01/01/2021", departure_city: "Denver", arrival_city: "New York")
		@two = @sky.flights.create!(number: 150, date: "02/01/2021", departure_city: "Portland", arrival_city: "Pittsburgh")
		@three = @rickety.flights.create!(number: 200, date: "03/01/2021", departure_city: "Seattle", arrival_city: "San Francisco")
		@four = @rickety.flights.create!(number: 250, date: "04/01/2021", departure_city: "Miami", arrival_city: "Los Angeles")

		@brad = @one.passengers.create!(name: "Brad", age: 34)
		@jeff = @one.passengers.create!(name: "Jeff", age: 35)
		@joe = @two.passengers.create!(name: "Joe", age: 36)
		@jim = @two.passengers.create!(name: "Jim", age: 37)
		@jane = @three.passengers.create!(name: "Jane", age: 38)
		@jill = @three.passengers.create!(name: "Jill", age: 39)
		@jimmy = @four.passengers.create!(name: "Jimmy", age: 40)
		@jenny = @four.passengers.create!(name: "Jenny", age: 41)
	end

	describe 'As a visit, when I visit the flights index page' do
		it 'see a list of all flight numbers and next to each flight number I see the name of the Airline of that flight' do
			visit "/flights"
			expect(page).to have_content("Flight Number: 101 Airline: Sky High")
			expect(page).to have_content("Flight Number: 150 Airline: Sky High")
			expect(page).to have_content("Flight Number: 200 Airline: Rickety Airlines")
			expect(page).to have_content("Flight Number: 250 Airline: Rickety Airlines")
		end
	end
end
