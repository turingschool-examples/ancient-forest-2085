class Passenger < ApplicationRecord
	has_many :flight_passengers
	has_many :flights, through: :flight_passengers

	def find_flight_passenger_by_flight(flight)
		flight_passengers.where("flight_passengers.flight_id = ?", flight.id).take
	end
end
