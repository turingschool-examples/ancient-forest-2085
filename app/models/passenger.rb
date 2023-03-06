class Passenger < ApplicationRecord
  has_many :passenger_flights
  has_many :flights, through: :passenger_flights

  def self.adult_passengers(airline)
    joins(flights: :airline)
      .where("airlines.id = ? AND passengers.age >= ?", airline.id, 18)
      .select("passengers.*")
      .distinct
  end
  
end