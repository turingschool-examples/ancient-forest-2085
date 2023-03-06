class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, through: :flight_passengers

  def uniq_passengers_list
    passengers.distinct.order(:name)
    # ordered by name so array would be consistent in model test
    # this would change if I had time to finish the extention
  end
end
