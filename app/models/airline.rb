class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def all_adult_passengers_sorted 
    passengers.joins(:flights)
              .where('passengers.age >= ?', 18)
              .select('passengers.*, count(distinct flights.*) as flight_count')
              .group(:id)
              .order('flight_count desc')
  end
end
