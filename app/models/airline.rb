class Airline < ApplicationRecord
  has_many :flights
  has_many :passenger_flights, through: :flights 
  has_many :passengers, through: :flights
  validates :name, presence: true

  def unique_list_adults
    self.passengers.where("age >= ?", 18).uniq
  end
end
