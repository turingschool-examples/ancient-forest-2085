require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe 'instance methods' do
    it 'reutns a list of unique passengers' do
      load_test_data
      expect(@southwest.distinct_adult_passengers).to eq([@passenger2, @passenger4])
    end
  end
end
