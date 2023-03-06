class Flight < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def find_flight_passenger(passenger)
    flight_passengers.where(flight_id: id, passenger_id: passenger.id).take
  end
end
