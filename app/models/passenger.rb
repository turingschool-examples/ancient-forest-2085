class Passenger < ApplicationRecord
  has_many :passenger_flights 
  has_many :flights, through: :passenger_flights

  def get_passenger_flight_id(flight)
    passenger_flights.where(passenger_id: self.id)
                     .where(flight_id: flight.id)
                     .pluck(:id)
                     .first
  end
end