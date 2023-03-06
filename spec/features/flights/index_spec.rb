require 'rails_helper'

RSpec.describe 'flights index page', type: :feature do
	let!(:united) { Airline.create!(name: 'United') }
	let!(:frontier) { Airline.create!(name: 'Frontier') }
	
	let!(:flight_1) { united.flights.create!(number: 1727, date: '08/30/22', departure_city: 'Denver', arrival_city: 'Reno') }
	let!(:flight_2) { united.flights.create!(number: 1832, date: '08/30/22', departure_city: 'Los Angeles', arrival_city: 'Austin') }
	let!(:flight_3) { united.flights.create!(number: 1655, date: '08/30/22', departure_city: 'Phoenix', arrival_city: 'Las Vegas') }
	let!(:flight_4) { frontier.flights.create!(number: 1726, date: '08/30/22', departure_city: 'New York', arrival_city: 'Seattle') }
	let!(:flight_5) { frontier.flights.create!(number: 1690, date: '08/30/22', departure_city: 'Portland', arrival_city: 'San Diego') }

	let!(:passenger_1) { Passenger.create!(name: 'Joe', age: 30) }
	let!(:passenger_2) { Passenger.create!(name: 'Mary', age: 25) }
	let!(:passenger_3) { Passenger.create!(name: 'John', age: 25) }
	let!(:passenger_4) { Passenger.create!(name: 'Michael', age: 25) }
	let!(:passenger_5) { Passenger.create!(name: 'Henry', age: 25) }
	let!(:passenger_6) { Passenger.create!(name: 'David', age: 25) }
	let!(:passenger_7) { Passenger.create!(name: 'Valerie', age: 25) }

	before do
		FlightPassenger.create!(flight: flight_1, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_1)
		FlightPassenger.create!(flight: flight_2, passenger: passenger_2)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_3)
		FlightPassenger.create!(flight: flight_3, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_4)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_5)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_6)
		FlightPassenger.create!(flight: flight_5, passenger: passenger_7)

		visit flights_path
	end

	describe 'flight numbers' do
		it 'has a list of all flight numbers and airline name' do
			expect(page).to have_content('All Flights')
			expect(page).to have_content("Flight ##{flight_1.number} - #{united.name}")
			expect(page).to have_content("Flight ##{flight_2.number} - #{united.name}")
			expect(page).to have_content("Flight ##{flight_3.number} - #{united.name}")
			expect(page).to have_content("Flight ##{flight_4.number} - #{frontier.name}")
			expect(page).to have_content("Flight ##{flight_5.number} - #{frontier.name}")
		end

		it 'has all passengers listed under each flight' do
			within "#flight-#{flight_1.id}" do
				expect(page).to have_content("Passengers:")
				within '#passengers' do
					expect(page).to have_content(passenger_1.name)
					expect(page).to_not have_content(passenger_3.name)
				end
			end

			within "#flight-#{flight_2.id}" do
				expect(page).to have_content("Passengers:")
				within '#passengers' do
					expect(page).to have_content(passenger_1.name)
					expect(page).to have_content(passenger_2.name)
				end
			end

			within "#flight-#{flight_3.id}" do
				expect(page).to have_content("Passengers:")
				within '#passengers' do
					expect(page).to have_content(passenger_3.name)
					expect(page).to have_content(passenger_4.name)
				end
			end

			within "#flight-#{flight_4.id}" do
				expect(page).to have_content("Passengers:")
				within '#passengers' do
					expect(page).to have_no_content
				end
			end

			within "#flight-#{flight_5.id}" do
				expect(page).to have_content("Passengers:")
				within '#passengers' do
					expect(page).to have_content(passenger_4.name)
					expect(page).to have_content(passenger_5.name)
					expect(page).to have_content(passenger_6.name)
					expect(page).to have_content(passenger_7.name)
				end
			end
		end
	end

	describe 'remove passenger from a flight' do
		it 'has a button next to each passenger name to remove from that flight' do
			within "#flight-#{flight_1.id}" do
				within "#passenger-#{passenger_1.id}" do
					expect(page).to have_button('Remove from Flight')
				end
			end

			within "#flight-#{flight_2.id}" do
				within "#passenger-#{passenger_2.id}" do
					expect(page).to have_button('Remove from Flight')
				end
			end

			within "#flight-#{flight_3.id}" do
				within "#passenger-#{passenger_3.id}" do
					expect(page).to have_button('Remove from Flight')
				end
				within "#passenger-#{passenger_4.id}" do
					expect(page).to have_button('Remove from Flight')
				end
			end

			within "#flight-#{flight_4.id}" do
				within '#passengers' do
					expect(page).to_not have_button('Remove from Flight')
				end
			end

			within "#flight-#{flight_5.id}" do
				within '#passengers' do
					within "#passenger-#{passenger_5.id}" do
						expect(page).to have_button('Remove from Flight')
					end
					within "#passenger-#{passenger_6.id}" do
						expect(page).to have_button('Remove from Flight')
					end
					within "#passenger-#{passenger_7.id}" do
						expect(page).to have_button('Remove from Flight')
					end
				end
			end
		end

		it 'removes passenger and redirects back to index page when button is clicked' do
			within "#flight-#{flight_1.id}" do
				expect(page).to have_content(passenger_1.name)
			end

			within "#flight-#{flight_2.id}" do
				expect(page).to have_content(passenger_1.name)

				within "#passenger-#{passenger_1.id}" do
					click_button 'Remove from Flight'
				end

				expect(page).to_not have_content(passenger_1.name)
			end

			within "#flight-#{flight_1.id}" do
				expect(page).to have_content(passenger_1.name)
			end
		end
	end
end
