class FlightPassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    flight_passenger = FlightPassenger.find_by(flight: flight, passenger_id: params[:id])
    flight_passenger.destroy
    redirect_to flights_path
  end
end