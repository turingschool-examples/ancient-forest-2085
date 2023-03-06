class FlightPassengersController < ApplicationController

  def destroy
    flight_passenger = FlightPassenger.where(flight_id: params[:id], passenger_id: params[:format]).first
    flight_passenger.destroy
    redirect_to flights_path
  end
end