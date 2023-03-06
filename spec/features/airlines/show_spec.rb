require "rails_helper"

RSpec.describe "Airlines Show Page" do
  before(:each) do
    load_airline_spec_data
    
    visit airline_path(@airline)
  end

  context 'User Story 3' do
    describe 'As a visitor' do
      describe "When I visit an airline's show page" do
        it "I can see a unique list of only adult passengers (age >= 18) that have flights on this airline" do
          within("#airline_adult_passengers") {
            expect(page).to have_content("Abdul")
            expect(page).to have_content("Adam")
            expect(page).to have_content("Chris")
            expect(page).to_not have_content("Kid")
          }
        end
      end
    end
  end

  context 'User Story 4' do
    describe 'As a visitor' do
      describe "When I visit an airline's show page" do
        it 'can see the list of adult passengers is sorted by number of flights each passenger has taken on the airline from most to least' do
          within("#airline_adult_passengers") {
            expect("Adam").to appear_before("Abdul")
            expect("Abdul").to appear_before("Chris")
          }
        end
      end
    end
  end
end