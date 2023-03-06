require 'rails_helper'

RSpec.describe 'airline show page', type: :feature do
	let!(:united) { Airline.create!(name: 'United') }
	let!(:frontier) { Airline.create!(name: 'Frontier') }

	describe 'links to index pages' do
		it 'has links to flights and airlines index page' do
			visit root_path

			expect(page).to have_link("Flight's Index Page", href: flights_path)
			expect(page).to have_link("Airline's Index Page", href: airlines_path)
			expect(page).to have_link("United's Show Page", href: airline_path(united))
			expect(page).to have_link("Frontier's Show Page", href: airline_path(frontier))
		end
	end
end