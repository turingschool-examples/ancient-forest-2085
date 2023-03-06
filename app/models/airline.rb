class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def distinct_passengers
    passengers.distinct
  end
end
