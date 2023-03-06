class Passenger < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers
end
