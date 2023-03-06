require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe 'instance methods' do
    it 'reutns a list of unique passengers' do
      load_test_data

      expect(@southwest.distinct_adult_passengers).to eq([@passenger4, @passenger2])
      expect(@southwest.distinct_adult_passengers.first.trip_count).to eq(2)
    end
  end
end
