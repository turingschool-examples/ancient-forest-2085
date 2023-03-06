class PassengerFlightsController < ApplicationController
  def destroy
    flight = Flight.find(params[:id])
    passenger = PassengerFlight.find(params[:passenger_id])
    binding.pry
    passenger.destroy
    redirect_to '/flights'
  end
end