class PassengersController < ApplicationController
  def destroy
    @flight = Flight.find(params[:id])
    @passenger = flight.passengers.find(params[:id])
    passenger.destroy
    redirect_to '/flights'
  end
end