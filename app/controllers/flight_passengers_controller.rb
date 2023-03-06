class FlightPassengersController < ApplicationController
	def destroy
		@flight_passenger = FlightPassenger.find_by(flight: params[:flight], passenger: params[:id])
		@flight_passenger.delete
		redirect_to flights_path
	end
end