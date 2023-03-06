class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers
  has_many :airlines, through: :flights

  validates_presence_of :name, :age
end
