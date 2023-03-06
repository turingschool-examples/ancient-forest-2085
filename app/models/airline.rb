class Airline < ApplicationRecord
  has_many :flights

  def list_passengers
    self.flights.joins(:passengers).where('passengers.age >= 18').distinct.pluck('passengers.name')
  end
end
