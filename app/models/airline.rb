class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def show_uniq_adults
    passengers.where("passengers.age >= 18").distinct
  end
end
