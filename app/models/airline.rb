class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, through: :flight_passengers

  def adult_passengers
    passengers.select('passengers.*, count(flights.id)')
              .distinct
              .where('passengers.age >= 18')
              .group(:id)
              .order('count(flights.id) DESC')
  end
end
