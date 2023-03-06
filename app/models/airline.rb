class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, through: :flight_passengers

  def unique_adult_names
    passengers.where("passengers.age > 18").distinct.order(:name).pluck(:name)
    # passengers.joins(:flight_passengers).select("passengers.*, COUNT(flight_passengers.id) AS flight_count").group("passengers.id").where("passengers.age > 18").order(flight_count: :desc).pluck(:name)
  end
end
