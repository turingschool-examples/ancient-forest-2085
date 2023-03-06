require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it {should have_many :passenger_flights}
    it {should have_many :flights}
  end
end