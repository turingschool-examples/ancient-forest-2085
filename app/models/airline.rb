class Airline < ApplicationRecord
  has_many :flights
  has_many :passenger_flights, through: :flights
  has_many :passengers, through: :passenger_flights

  def unique_passengers
    passengers.distinct.where("age >= 18").pluck(:name)
  end
end
