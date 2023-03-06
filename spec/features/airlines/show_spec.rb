require 'rails_helper'

describe 'Airline Show Page' do
  before(:each) do
    @frontier = Airline.create!(name: "Frontier")
    w = Date.new(2023, 3, 6)
    x = Date.new(2023, 3, 7)

    @f1 = @frontier.flights.create!(number: 1, date: w, departure_city: "Denver", arrival_city: "Los Angeles")
    @f2 = @frontier.flights.create!(number: 6, date: x, departure_city: "Denver", arrival_city: "San Diego")

    @p1 = @f1.passengers.create!(name: "Joe", age: 27)
    @p2 = @f1.passengers.create!(name: "Tori", age: 23)
    @p3 = @f1.passengers.create!(name: "Joel", age: 44)
    @p4 = @f1.passengers.create!(name: "Corrie", age: 44)
    @p5 = @f2.passengers.create!(name: "Amy", age: 47)
    @p6 = @f2.passengers.create!(name: "Sam", age: 15)
    @p7 = @f2.passengers.create!(name: "Billy", age: 25)
    @p8 = @f2.passengers.create!(name: "Meghan", age: 10)

    FlightPassenger.create!(flight: @f2, passenger: @p1)
    FlightPassenger.create!(flight: @f2, passenger: @p2)

    visit airline_path(@frontier)
  end

  describe "As a visitor when I visit an airline's show page" do
    it 'I see a list of passengers that have flights on that airline, I see that this list is unique (no duplicate passengers)' do
      expect(page).to have_content("Joe: 27", count: 1)
      expect(page).to have_content("Tori: 23", count: 1)
      expect(page).to have_content("Joel: 44", count: 1)
      expect(page).to have_content("Corrie: 44", count: 1)
      expect(page).to have_content("Billy: 25", count: 1)
      expect(page).to have_content("Amy: 47", count: 1)
    end

    it 'I see that this list only includes adult passengers' do
      expect(page).to have_no_content("Sam")
      expect(page).to have_no_content("Meghan")
      save_and_open_page
    end
  end
end