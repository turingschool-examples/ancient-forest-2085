class PassengersController < ApplicationController
  def destroy
    @passenger = Passenger.find(params[:id])
    @passenger.flights.destroy(params[:flight_id])

    redirect_to flights_path
  end
end