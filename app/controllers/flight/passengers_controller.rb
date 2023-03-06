class Flight::PassengersController < ApplicationController
  def destroy
    flight_passenger = FlightPassenger.find_by(passenger_id: params[:id], flight_id: params[:flight_id])

    flight_passenger.destroy

    redirect_to flights_path
  end
end