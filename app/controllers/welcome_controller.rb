class WelcomeController < ApplicationController
	def index
		@airlines = Airline.all
	end
end