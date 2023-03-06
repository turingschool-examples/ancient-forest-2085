class Passenger < ApplicationRecord
  has_many :passenger_flights
  has_many :flights, through: :passenger_flights

  def self.adult_passengers_sorted(airline)
    joins(flights: :airline)
    select("passengers.*, COUNT(passenger_flights.id) AS flight_count")
      .joins(:passenger_flights => {:flight => :airline})
      .where("airlines.id = ? AND passengers.age >= ?", airline.id, 18)
      .group("passengers.id")
      .order("flight_count DESC")
  end 
end