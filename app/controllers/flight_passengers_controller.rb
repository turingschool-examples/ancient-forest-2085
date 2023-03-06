class FlightPassengersController < ApplicationController
  def destroy
    @passenger = FlightPassenger.find(params[:id])
    @passenger.destroy
    redirect_to "/flights"
  end
end