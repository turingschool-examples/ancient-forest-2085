require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many :passenger_flights}
    it {should have_many :passengers}
  end
end
