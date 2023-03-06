class PassengerFlightsController < ApplicationController

  def destroy
    passenger_flight = PassengerFlight.find(passenger_flights_params)
    passenger_flight.destroy
    redirect_to '/flights'
  end

  def passenger_flights_params
    params.permit(:passenger_id, :fight_id)
  end

end