require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it { should have_many(:passenger_flights).through(:flights)}
    it { should have_many(:passengers).through(:flights)}
    
  end

  describe "validations" do 
    it { should validate_presence_of :name }
  end

  describe "instance methods" do 
    it "can get a unique list of adult passengers" do 
      @airline1 = Airline.create!(name: "Spirit")
      @airline2 = Airline.create!(name: "Jetblue")
    
      @flight1 = @airline1.flights.create!(number: 23, date: "March 1, 2023", departure_city: "Mexico City", arrival_city: "Puerto Escondido") 
      @flight3 = @airline1.flights.create!(number: 86, date: "March 1, 2023", departure_city: "Beirut", arrival_city: "Jordan") 
    
      @flight2 = @airline2.flights.create!(number: 45, date: "Jan 1, 2023", departure_city: "San Diego", arrival_city: "Los Angelas") 
      
      @passenger1 = Passenger.create!(name: "Hady", age: 33)
      @passenger2 = Passenger.create!(name: "Malena", age: 26)
      @passenger3 = Passenger.create!(name: "Axel", age: 26)
      @passenger4 = Passenger.create!(name: "Athena", age: 4)
      @pf1 = PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
      @pf2 =PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
      @pf3 =PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)
      @pf3 =PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight3.id)
      @pf3 =PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight1.id)

      expect(@airline1.unique_list_adults).to eq([@passenger1, @passenger2])

    end
  end
end
