class Airline < ApplicationRecord
  has_many :flights
	has_many :passengers, through: :flights

	def unique_adult_passengers
		passengers.where("passengers.age >= 18").distinct
	end

	def sorted_unique_adult_passengers
		passengers
		.where("passengers.age >= 18")
		.select("passengers.*, COUNT(flights.*) as flight_count")
		.group(:id)
		.order(flight_count: :desc)
	end
end
