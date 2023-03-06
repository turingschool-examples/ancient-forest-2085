class PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:id])
    passenger = flight.passengers.find(params[:passenger_id])
    passenger.destroy
    redirect_to '/flights'
  end
end