class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, through: :flights

  def unique_passengers
    passengers.distinct.where("age >= 18").pluck(:name)
  end
end
