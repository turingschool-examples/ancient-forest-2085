class PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    passengers = flight.passengers.find(params[:id]).destroy
    redirect_to "/flights"
  end
end