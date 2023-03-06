class Passenger < ApplicationRecord
  has_many :passenger_flights
  has_many :flights, through: :passenger_flights
end

def passenger_names
  passengers.pluck(:name)
end