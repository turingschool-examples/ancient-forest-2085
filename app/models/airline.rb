class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def distinct_adult_passengers
    passengers.where('passengers.age >= ?', 18)
    .select('passengers.*, count(passengers.id) as flight_count')
    .group('passengers.id')
    .order('flight_count DESC')
    .distinct
  end
end
