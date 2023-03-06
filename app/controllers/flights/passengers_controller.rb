class Flights::PassengersController < ApplicationController
  def index
    @flight = Flight.find(params[:flight_id])
    @passenger = @flight.passengers.find(params[:passenger_id])
  end

  def update
    # require 'pry'; binding.pry
    passenger = Passenger.find(params[:id])
    passenger.passenger_flights.update(passenger_flight_params)
    redirect_to flights_path
  end

  def passenger_flight_params
    params.permit(:status)
  end
end