class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passengers, through: :passenger_flights
  has_many :passenger_flights
end
