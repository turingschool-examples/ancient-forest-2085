class Passenger < ApplicationRecord
  has_many :passenger_flights, dependent: :destroy
	has_many :flights, through: :passenger_flights

	def self.unique_passengers_over_18
		where("age >= 18").
		select(:name).distinct
	end
end
