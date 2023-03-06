class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def unique_passengers
    passengers.where("age >= 18").distinct
  end
end
