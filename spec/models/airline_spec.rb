require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe '#instance methods' do 
    it 'find_all_passengers' do 
      @airline1 = Airline.create!(name: "Delta")
      @airline2 = Airline.create!(name: "United")
  
      @flight1 = Flight.create!(number: "12345", date: "1/1/2024", departure_city: "Denver", arrival_city: "Boston", airline_id: @airline1.id)
      @flight2 = Flight.create!(number: "56789", date: "1/1/2024", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: @airline1.id)
  
      @flight3 = Flight.create!(number: "34567", date: "1/1/2024", departure_city: "Denver", arrival_city: "New York", airline_id: @airline2.id)
      @flight4 = Flight.create!(number: "23456", date: "1/1/2024", departure_city: "Denver", arrival_city: "Cancun", airline_id: @airline2.id)
  
      @passenger1 = Passenger.create!(name: "Brian", age: 20)
      @passenger2 = Passenger.create!(name: "John", age: 18)
      @passenger3 = Passenger.create!(name: "Carolyn", age: 7)
  
      PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
      PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
  
      PassengerFlight.create!(passenger: @passenger3, flight: @flight1)

      PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
      PassengerFlight.create!(passenger: @passenger2, flight: @flight2)
   
      expect(@airline1.find_all_passengers).to eq([@passenger1, @passenger2])
    end
  end
end
