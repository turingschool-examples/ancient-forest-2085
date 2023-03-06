require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:flight_passengers).through(:flights)}
    it {should have_many(:passengers).through(:flight_passengers)}

  end

  describe 'instance methods' do
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
    end

    it 'can return distinct adult passengers from database' do
      expect(@frontier.adult_passengers).to include(@p1, @p2, @p3, @p4, @p5, @p7)
      expect(@frontier.adult_passengers).not_to include(@p6, @p8)
    end
  end
end
