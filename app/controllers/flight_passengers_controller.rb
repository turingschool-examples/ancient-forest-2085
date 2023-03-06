class FlightPassengersController < ApplicationController
  def destroy
    flight_passenger = FlightPassenger.find_by(flight_id: params[:flight_id], passenger_id: params[:id])

    flight_passenger.destroy

    flash[:notice] = "Passenger was removed from this flight"

    redirect_to flights_path
  end
end