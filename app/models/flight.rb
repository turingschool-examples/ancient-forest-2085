class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  # def passenger_names
  #   passengers.pluck(:name)
  # end
end
