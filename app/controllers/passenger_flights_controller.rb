class PassengerFlightsController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:id])
    passenger_flight = PassengerFlight.find_by(flight: flight, passenger: passenger)
    passenger_flight.destroy
    redirect_to flights_path
  end
end