class PassengerFlight < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight

  enum status: [:active, :inactive]
end
