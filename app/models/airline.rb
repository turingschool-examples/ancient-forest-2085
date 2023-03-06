class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  validates_presence_of :name

  def unique_adult_passengers
    passengers.select("passengers.*, count(flight_passengers.id) as num_flights")
      .where("age >= ?", 18)
      .group(:id)
      .order("num_flights desc")
  end
end
