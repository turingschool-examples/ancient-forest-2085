class Airline < ApplicationRecord
  has_many :flights

  def adult_passengers
    flights.joins(:passengers)
    .where('passengers.age >= 18')
    .distinct
    .pluck(:name)
  end
end
