class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  # def active_passengers
  #   passengers.where(status: 0)
  # end

  # def inactive_passengers
  #   passengers.where(status: 1)
  # end
end
