class AirlinesController < ApplicationController

	def show
		@airline = Airline.find(params[:id])
		@unique = @airline.passengers.unique_passengers_over_18
	end
end