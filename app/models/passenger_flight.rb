class PassengerFlight < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight

  def self.find_pf(passenger, flight)
    self.where(flight_id: flight).where(passenger_id: passenger)

  end
end
