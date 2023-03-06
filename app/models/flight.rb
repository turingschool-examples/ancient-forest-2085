class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights
  validates :number, presence: true, numericality: true
  validates :date, presence: true
  validates :departure_city, presence: true
  validates :arrival_city, presence: true



end
