require 'rails_helper'

describe Passenger, type: :model do
  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:flights).through(:flight_passengers) }
  end
end