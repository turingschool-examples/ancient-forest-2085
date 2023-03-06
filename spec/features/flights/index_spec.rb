require "rails_helper"

RSpec.describe "Flights Index Page" do
  before(:each) do
    load_flight_spec_data
    
    visit flights_path
  end

  context 'User Story 1' do
    describe 'As a visitor' do
      describe 'When I visit the flights index page' do
        it 'can see a list of all flight numbers with the Airline name beside that and all flight passengers listed below' do
          within("#flight-#{@flight_1.id}") {
            expect(page).to have_content("Flight Number: 1111 | Airline: Emirates")
            within("#passengers") {
              expect(page).to have_content("Adam")
            }
          }

          within("#flight-#{@flight_2.id}") {
            expect(page).to have_content("Flight Number: 2222 | Airline: Emirates")
            within("#passengers") {
              expect(page).to have_content("Abdul")
              expect(page).to have_content("Adam")
              expect(page).to have_content("Chris")
            }
          }

          within("#flight-#{@flight_3.id}") {
            expect(page).to have_content("Flight Number: 3333 | Airline: Emirates")
            within("#passengers") {
              expect(page).to have_content("Chris")
            }
          }

          within("#flight-#{@flight_4.id}") {
            expect(page).to have_content("Flight Number: 4444 | Airline: Emirates")
            within("#passengers") {
              expect(page).to have_content("Abdul")
            }
          }
        end
      end
    end
  end

  context 'User Story 2' do
    describe 'As a visitor' do
      describe 'When I visit the flights index page' do
        it "there is a button to remove a passenger from the flight next to that passenger's name" do
          within("#flight-#{@flight_2.id}") { 
            within("#passenger-#{@abdul.id}") { expect(page).to have_button("Remove Passenger") }
            within("#passenger-#{@adam.id}") { expect(page).to have_button("Remove Passenger") }
            within("#passenger-#{@chris.id}") { expect(page).to have_button("Remove Passenger") }
          }
        end

        it "when 'Remove Passenger' is clicked, I'm returned to the flight index page and no longer see that passenger listed under that flight" do
          within("#flight-#{@flight_2.id}") { 
            within("#passenger-#{@adam.id}") { click_button "Remove Passenger" }
          }

          expect(current_path).to eq(flights_path)

          within("#flight-#{@flight_2.id}") { 
            within("#passengers") { expect(page).to_not have_content("Adam") }
          }
        end

        it 'can still see the passenger on their other flights after removing from a different flight' do
          within("#flight-#{@flight_2.id}") { 
            within("#passenger-#{@adam.id}") { click_button "Remove Passenger" }
          }

          within("#flight-#{@flight_1.id}") { expect(page).to have_content("Adam") } 
        end
      end
    end
  end
end