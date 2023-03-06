require 'rails_helper'

RSpec.describe 'airline index page', type: :feature do
	let!(:united) { Airline.create!(name: 'United') }
	let!(:frontier) { Airline.create!(name: 'Frontier') }
	
	let!(:flight_1) { united.flights.create!(number: 1727, date: '08/30/22', departure_city: 'Denver', arrival_city: 'Reno') }
	let!(:flight_2) { united.flights.create!(number: 1832, date: '08/30/22', departure_city: 'Los Angeles', arrival_city: 'Austin') }
	let!(:flight_3) { united.flights.create!(number: 1655, date: '08/30/22', departure_city: 'Phoenix', arrival_city: 'Las Vegas') }
	let!(:flight_4) { united.flights.create!(number: 1726, date: '08/30/22', departure_city: 'New York', arrival_city: 'Seattle') }
	let!(:flight_5) { frontier.flights.create!(number: 1690, date: '08/30/22', departure_city: 'Portland', arrival_city: 'San Diego') }


	describe 'shows all airlines' do
		it 'displays all airlines and are links to show pages' do
			visit airlines_path
			
			expect(page).to have_link(united.name, href: airline_path(united))
			expect(page).to have_link(frontier.name, href: airline_path(frontier))
		end
	end

end