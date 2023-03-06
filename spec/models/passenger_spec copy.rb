require 'rails_helper'

RSpec.describe PassengerFlight, type: :model do
  describe 'relationships' do
    it { should have_many :passengers}
    it { should have_many :flights }
  end
end
