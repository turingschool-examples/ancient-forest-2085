class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, -> { distinct }, through: :flight_passengers

  def adult_passengers
    passengers.where('passengers.age >= 18')
  end
end
