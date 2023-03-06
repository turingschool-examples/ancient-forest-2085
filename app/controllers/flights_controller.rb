class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def update
    flight = Flight.find(params[:id])
    passenger = flight.passengers.find(params[:passenger_id])
    passenger.passenger_flights.update!(passanger_flight_params)
    redirect_to flights_path
  end

  def passanger_flight_params
    params.permit(:status)
  end
end