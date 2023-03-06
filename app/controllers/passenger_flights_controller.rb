class PassengerFlightsController < ApplicationController

  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:passenger_id])
    # binding.pry
    # passenger_flight = PassengerFlight.find(:flight_id: flight.id, :passenger_id: passenger.id)
    # passenger_flight.find(passenger_flights_params)
    passenger_flight = PassengerFlight.where(flight_id: flight.id).where(passenger_id: passenger.id).first
    passenger_flight.destroy
    redirect_to '/flights'
  end

  def passenger_flights_params
    params.permit(:passenger_id, :flight_id)
  end

end