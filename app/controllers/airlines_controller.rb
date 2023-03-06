class AirlinesController < ApplicationController
	def index
		@airlines = Airline.all
	end
	
	def show
		@airline = Airline.find(params[:id])
		@passengers = @airline.sorted_unique_adult_passengers
	end
end