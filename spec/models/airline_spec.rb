require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many :flights }
    it { should have_many :passengers }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#Instance Methods' do
    describe '#unique_adult_passengers' do
      before(:each) do
        load_airline_spec_data
      end

      it 'returns all unique adult passengers (age >= 18), sorted from most flights on airline to least' do
        expect(@airline.unique_adult_passengers).to eq([@adam, @abdul, @chris])
      end
      
      it 'will secondarily sort alphabetically by name if there are equal numbers of flights between passengers' do
        FlightPassenger.create!(flight: @flight_2, passenger: @abdul)

        expect(@airline.unique_adult_passengers).to eq([@abdul, @adam, @chris])
      end
    end
  end
end
