class PassengerFlightsController < ApplicationController
  def destroy
    @flight = Flight.find(params[:id])
    # passenger = PassengerFlight.find(params[:passenger_id])

    passenger = PassengerFlight.find_by(flight_id:params[:id], passenger_id:params[:passenger_id])

    passenger.destroy
    redirect_to '/flights'
  end
end