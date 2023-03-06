class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def unique_passengers
    passengers.where("age >= 18").distinct
  end

  def passengers_sorted_by_flights
    unique_passengers.joins(:flights).select("passengers.*, count(DISTINCT flights.id) as flight_count").group(:id).order("flight_count DESC")
  end
end
