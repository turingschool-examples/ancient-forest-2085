class Flight::PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    
    FlightPassenger.destroy(params[:id])

    redirect_to flights_path
  end
end