class PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = flight.passengers.find(params[:id])
    flight.passengers.destroy(passenger)
    # this is only deleting one passenger from the flight passengers
    redirect_to "/flights"
  end
end