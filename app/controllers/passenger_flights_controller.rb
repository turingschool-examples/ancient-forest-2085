class PassengerFlightsController < ApplicationController
  def destroy
    passenger_flight = PassengerFlight.find_by(flight_id: params[:flight], passenger_id: params[:id])
    passenger_flight.destroy
    redirect_to flights_path
  end
end