class PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    flight_passenger = Passenger.find(params[:id])
    flight.passengers.destroy(flight_passenger)
    redirect_to flights_path
  end
end