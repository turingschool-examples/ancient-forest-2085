class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights


  def uniq_adult_passengers
    self.passengers.where("passengers.age >= 18").distinct
  end

end
