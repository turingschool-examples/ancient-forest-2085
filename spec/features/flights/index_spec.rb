require 'rails_helper'

RSpec.describe 'Flights Index Page', type: :feature do

  let!(:united) { Airline.create!(name: 'United Airlines') }
  let!(:southwest) { Airline.create!(name: 'Southwest Airlines') }

  let!(:flight_1) { united.flights.create!(number: "1234", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno") }
  let!(:flight_2) { united.flights.create!(number: "2345", date: "08/04/20", departure_city: "Denver", arrival_city: "Salt Lake City") }
  let!(:flight_3) { united.flights.create!(number: "3456", date: "08/05/20", departure_city: "Denver", arrival_city: "New York") }
  let!(:flight_4) { united.flights.create!(number: "4567", date: "08/06/20", departure_city: "Reno", arrival_city: "Denver") }
  let!(:flight_5) { southwest.flights.create!(number: "1233", date: "08/06/20", departure_city: "Reno", arrival_city: "Denver") }

  let!(:tom) { Passenger.create!(name: "Tom Haveford", age: 32) }
  let!(:leslie) { Passenger.create!(name: "Leslie Knope", age: 45) }
  let!(:april) { Passenger.create!(name: "April Ludgate", age: 31) }
  let!(:andy) { Passenger.create!(name: "Andy Dweyer", age: 35) }
  let!(:ron) { Passenger.create!(name: "Ron Swanson", age: 53) }
  let!(:ben) { Passenger.create!(name: "Ben Wyatt", age: 46) }
  let!(:chris) { Passenger.create!(name: "Chris Traeger", age: 54) }
  let!(:jerry) { Passenger.create!(name: "Jerry Grugich", age: 59) }

  before(:each) do
    FlightPassenger.create!(flight: flight_1, passenger: tom)
    FlightPassenger.create!(flight: flight_1, passenger: april)
    FlightPassenger.create!(flight: flight_1, passenger: andy)
    FlightPassenger.create!(flight: flight_2, passenger: leslie)
    FlightPassenger.create!(flight: flight_2, passenger: ben)
    FlightPassenger.create!(flight: flight_3, passenger: chris)
    FlightPassenger.create!(flight: flight_3, passenger: ron)
    FlightPassenger.create!(flight: flight_4, passenger: tom)
    FlightPassenger.create!(flight: flight_4, passenger: april)
    FlightPassenger.create!(flight: flight_4, passenger: andy)
    FlightPassenger.create!(flight: flight_5, passenger: jerry)

    visit flights_path
  end

  describe 'As a visitor' do
    describe "when I visit a flight's index page" do
      it 'I see a list of all flight numbers' do
        within 'section#flight_info' do
          expect(page).to have_content("Flight ##{flight_1.number}")
          expect(page).to have_content("Flight ##{flight_2.number}")
          expect(page).to have_content("Flight ##{flight_3.number}")
          expect(page).to have_content("Flight ##{flight_4.number}")
          expect(page).to have_content("Flight ##{flight_5.number}")
        end
      end

      it 'next to each flight number I see the name of the Airline of that flight' do
        within 'section#flight_info' do
          expect(page).to have_content("Flight ##{flight_1.number}, Airline: #{united.name}")
          expect(page).to have_content("Flight ##{flight_2.number}, Airline: #{united.name}")
          expect(page).to have_content("Flight ##{flight_3.number}, Airline: #{united.name}")
          expect(page).to have_content("Flight ##{flight_4.number}, Airline: #{united.name}")
          expect(page).to have_content("Flight ##{flight_5.number}, Airline: #{southwest.name}")
        end
      end

      it "under each flight number I see the names of all that flight's passengers" do
        within "ul#passengers-#{flight_1.id}" do
          expect(page).to have_content("#{tom.name}")
          expect(page).to have_content("#{april.name}")
          expect(page).to have_content("#{andy.name}")
        end
        within "ul#passengers-#{flight_2.id}" do
          expect(page).to have_content("#{leslie.name}")
          expect(page).to have_content("#{ben.name}")
        end
        within "ul#passengers-#{flight_3.id}" do
          expect(page).to have_content("#{ron.name}")
          expect(page).to have_content("#{chris.name}")
        end
        within "ul#passengers-#{flight_4.id}" do
          expect(page).to have_content("#{tom.name}")
          expect(page).to have_content("#{april.name}")
          expect(page).to have_content("#{andy.name}")
        end
        within "ul#passengers-#{flight_5.id}" do
          expect(page).to have_content("#{jerry.name}")
        end
      end

      it 'next to each passenger, I see a link or button to remove that passenger from that flight' do
        within "ul#passengers-#{flight_1.id}" do
          expect(page).to have_button("Remove #{tom.name}")
          expect(page).to have_button("Remove #{april.name}")
          expect(page).to have_button("Remove #{andy.name}")
        end
      end

      it 'when I click to delete a passenger, I am brought back to the flights index, where I no longer see that passenger listed under that flight' do
        within "ul#passengers-#{flight_1.id}" do
          click_button "Remove #{tom.name}"
        end

        expect(current_path).to eq('/flights')

        within "ul#passengers-#{flight_1.id}" do
          expect(page).to_not have_content("#{tom.name}")
          expect(page).to have_content("#{april.name}")
          expect(page).to have_content("#{andy.name}")
        end

        within "ul#passengers-#{flight_4.id}" do
          expect(page).to have_content("#{tom.name}")
          expect(page).to have_content("#{april.name}")
          expect(page).to have_content("#{andy.name}")
        end
      end
    end
  end
end