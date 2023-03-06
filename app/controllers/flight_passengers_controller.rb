class FlightPassengersController < ApplicationController
  def destroy
    # require 'pry'; binding.pry
    @flight = Flight.find(params[:flight_id])
    @passenger = FlightPassenger.find(params[:id])
    @passenger.destroy
    redirect_to "/flights"
  end

  private

  def flight_passenger_params
    params.permit(:flight_id)
  end
end