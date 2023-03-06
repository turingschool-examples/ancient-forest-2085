class Passenger < ApplicationRecord
  has_many :passenger_flights
  has_many :flights, through: :passenger_flights
  validates :age, presence: true, numericality: true
  validates :name, presence: true


end
