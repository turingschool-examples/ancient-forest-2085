class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  validates_presence_of :name

  def unique_adult_passengers
    self.passengers.distinct.where("age >= ?", 18)
  end
end
