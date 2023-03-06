class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def adult_passengers
    passengers.select('DISTINCT passengers.id, passengers.name')
    .where('passengers.age >= 18')
  end
end
