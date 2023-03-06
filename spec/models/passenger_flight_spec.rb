require 'rails_helper'

RSpec.describe PassengerFlight, type: :model do
  describe 'relationships' do
    it {should belong_to :passenger}
    it {should belong_to :flight}

  end

  it "can find the appropriate passenger_flight" do 
    @airline1 = Airline.create!(name: "Spirit")
    @airline2 = Airline.create!(name: "Jetblue")
  
    @flight1 = @airline1.flights.create!(number: 23, date: "March 1, 2023", departure_city: "Mexico City", arrival_city: "Puerto Escondido") 
    
    @flight2 = @airline2.flights.create!(number: 45, date: "Jan 1, 2023", departure_city: "San Diego", arrival_city: "Los Angelas") 
    
    @passenger1 = Passenger.create!(name: "Hady", age: 33)
    @passenger2 = Passenger.create!(name: "Malena", age: 26)
    @passenger3 = Passenger.create!(name: "Axel", age: 26)
    @pf1 = PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
    @pf2 =PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
    @pf3 =PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)

    passenger = @passenger1.id 
    flight = @flight1.id 

    expect(PassengerFlight.find_pf(passenger, flight)).to eq([@pf1])
  end
end