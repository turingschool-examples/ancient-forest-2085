class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def all_adult_passengers 
   passengers.where('passengers.age >= ?', 18).distinct
  end
end
