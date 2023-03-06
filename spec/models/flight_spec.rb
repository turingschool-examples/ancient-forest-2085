require 'rails_helper'

RSpec.describe Flight, type: :model do
  let!(:united) { Airline.create!(name: "United") }
  let!(:southwest) { Airline.create!(name: "Southwest") }

  let!(:flight_1) { Flight.create!(number: "208", date: "08/22/2023", departure_city: "Denver", arrival_city: "Honolulu", airline_id: united.id) }
  let!(:flight_2) { Flight.create!(number: "300", date: "08/22/2023", departure_city: "San Francisco", arrival_city: "Chicago", airline_id: united.id) }

  let!(:flight_3) { Flight.create!(number: "178", date: "08/22/2023", departure_city: "Miami", arrival_city: "Portland", airline_id: southwest.id) }


  describe 'relationships' do
    it { should belong_to :airline }
    it { should have_many :flight_passengers}
    it { should have_many(:passengers).through(:flight_passengers) }
  end
end