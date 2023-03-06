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
    @passenger1 = Passenger.create!(name: 'Mark', age: 36)
    @passenger2 = Passenger.create!(name: 'Jane', age: 40)
    @passenger3 = Passenger.create!(name: 'Julia', age: 25)
    @passenger4 = Passenger.create!(name: 'Douglas', age: 25)
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger3.id)
    visit flights_path
  end

  it 'has a list of all flight numbers and the airline of that flight' do   #USER STORY 1
    expect(page).to have_content("Flight Number: #{@flight1.number}, Airline: #{@flight1.airline.name}")
    expect(page).to have_content("Flight Number: #{@flight2.number}, Airline: #{@flight2.airline.name}")
    expect(page).to have_content("Flight Number: #{@flight3.number}, Airline: #{@flight3.airline.name}")
    expect(page).to have_content("Flight Number: #{@flight4.number}, Airline: #{@flight4.airline.name}")
    expect(page).to have_content("Flight Number: #{@flight5.number}, Airline: #{@flight5.airline.name}")
  end

  it 'under each flight number I see the names of that flight\'s passengers' do
    within ("div#flight#{@flight1.id}") do
      expect("Flight Number: #{@flight1.number}").to appear_before(@passenger1.name)
      expect("Flight Number: #{@flight1.number}").to appear_before(@passenger2.name)
      expect("Flight Number: #{@flight1.number}").to appear_before(@passenger3.name)
    end

    expect(page).to_not have_content(@passenger4.name)
  end
end