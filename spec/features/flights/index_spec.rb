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
    let!(:sara) { Passenger.create!(name: "Sara", age: 29) }
    let!(:rachel) { Passenger.create!(name: "Rachel", age: 15) }
    let!(:gina) { Passenger.create!(name: "Gina", age: 36) }

    before do
      flight1.flight_passengers.create!(passenger: bob)
      flight1.flight_passengers.create!(passenger: rob)
      flight2.flight_passengers.create!(passenger: sara)
      flight3.flight_passengers.create!(passenger: rachel)
      flight3.flight_passengers.create!(passenger: sara)
      flight4.flight_passengers.create!(passenger: gina)

      visit flights_path
    end

    describe 'As a visitor' do 
      context 'When I visit flights index' do 
        it 'I see a list of each flight number' do
          expect(page).to have_content("Flight Number: 343")
          expect(page).to have_content("Flight Number: 336")
          expect(page).to have_content("Flight Number: 3276")
          expect(page).to have_content("Flight Number: 5542")
        end

        it "And next to each flight number I see the name of the Airline of that flight" do
          expect(page).to have_content("343 | Airline: SouthWest")
          expect(page).to have_content("336 | Airline: SouthWest")
          expect(page).to have_content("3276 | Airline: SouthWest")
          expect(page).to have_content("5542 | Airline: United")
        end

        it "And under each flight number I see the names of all that flight's passengers" do
          within "div#flight-#{flight1.id}" do
            expect(page).to have_content("Bob")
            expect(page).to have_content("Rob")
          end

          within "div#flight-#{flight2.id}" do
            expect(page).to have_content("Sara")
          end

          within "div#flight-#{flight3.id}" do
            expect(page).to have_content("Rachel")
            expect(page).to have_content("Sara")
          end

          within "div#flight-#{flight4.id}" do
            expect(page).to have_content("Gina")
          end
        end

        xit "Next to each passengers name I see a link to remove that passenger from that flight" do
          within "div#flight-#{flight1.id}" do
            expect(page).to have_link("Remove")
          end

          within "div#flight-#{flight2.id}" do
            expect(page).to have_link("Remove")
          end

          within "div#flight-#{flight3.id}" do
            expect(page).to have_link("Remove")
          end

          within "div#flight-#{flight4.id}" do
            expect(page).to have_link("Remove")
          end
        end

        xit "When I click on that link I'm returned to the flights index page" do
          within "div#flight-#{flight2.id}" do
            click_link "Remove"
          end

          expect(current_path).to eq(flights_path)
        end

        xit "And I no longer see that passenger listed under that flight, nd I still see the passenger listed under the other flights they were assigned to" do
          within "div#flight-#{flight2.id}" do
            click_link "Remove"
          end

          expect(current_path).to eq(flights_path)

          within "div#flight-#{flight2.id}" do
            expect(page).to_not have_content("Sara")
          end

          within "div#flight-#{flight3.id}" do
            expect(page).to have_content("Rachel")
            expect(page).to have_content("Sara")
          end
        end
      end
    end
  end
end