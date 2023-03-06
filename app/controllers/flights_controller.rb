class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  # def destroy
  #   Passenger.find(params[:id]).destroy

  #   redirect_to flights_path
  # end
end