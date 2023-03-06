require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end
  before (:each) do
    @airline_1 = Airline.create!(name: "Frontier")
    @flight_1 = @airline_1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @jade = Passenger.create!(name: "Jade", age: 25, status: 0)
    @hannah = Passenger.create!(name: "Hannah", age: 25, status: 1)
    PassengerFlight.create!(passenger: @jade, flight: @flight_1)
    PassengerFlight.create!(passenger: @hannah, flight: @flight_1)
  end
  # it 'can find all active passengers' do
  #   expect(@flight_1.active_passengers).to eq([@jade])
  # end

  # it 'can find all inactive passengers' do
  #   expect(@flight_1.inactive_passengers).to eq([@hannah])
  # end
end
