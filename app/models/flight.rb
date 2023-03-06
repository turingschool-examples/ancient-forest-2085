class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def list_of_passengers
    passengers.select(:name).distinct.pluck(:name)
  end
end
