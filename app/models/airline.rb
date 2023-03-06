class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights
  

  # def distinct_adult_passengers
  #   passengers.distinct.where('age >= ?', 18)
  # end

  def distinct_adult_passengers
    passengers.where('age >= ?', 18)
              .select('passengers.*, COUNT(flights.id) as trip_count')
              .group('passengers.id')
              .order('trip_count DESC')
  end

end
