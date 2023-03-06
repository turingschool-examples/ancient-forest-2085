require 'rails_helper'


describe 'flights index page' do

  before do
    @airline1 = Airline.create!(name: 'American Airlines')
    @airline2 = Airline.create!(name: 'Southwest')
    @airline3 = Airline.create!(name: 'United')
    @flight1 = Flight.create!(airline_id: @airline1.id, number: "1727", date: "06/05/22", departure_city: "Dallas", arrival_city: 'Chicago')
    @flight2 = Flight.create!(airline_id: @airline1.id, number: "1337", date: "06/05/22", departure_city: "Denver", arrival_city: 'Dallas')
    @flight3 = Flight.create!(airline_id: @airline1.id, number: "0987", date: "06/05/22", departure_city: "Atlanta", arrival_city: 'Denver')
    @flight4 = Flight.create!(airline_id: @airline2.id, number: "1234", date: "06/05/22", departure_city: "LA", arrival_city: 'Portland')
    @flight5 = Flight.create!(airline_id: @airline3.id, number: "5678", date: "06/05/22", departure_city: "Seattle", arrival_city: 'Chicago')

  end
  it 'has a list of all flight numbers and the airline of that flight' do
    expect(page).to have_content("Flight Number: #{@flight1.number}, Airline: #{@flight1.airline}")
    expect(page).to have_content("Flight Number: #{@flight2.number}, Airline: #{@flight2.airline}")
    expect(page).to have_content("Flight Number: #{@flight3.number}, Airline: #{@flight3.airline}")
    expect(page).to have_content("Flight Number: #{@flight4.number}, Airline: #{@flight4.airline}")
    expect(page).to have_content("Flight Number: #{@flight5.number}, Airline: #{@flight5.airline}")
  end
end