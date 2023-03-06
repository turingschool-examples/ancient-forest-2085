class Flights::PassengersController < ApplicationController
  def destroy
    # binding.pry
    @flight = Flight.find(params[:flight_id])
    @passenger = @flight.passengers.find(params[:id])
    @passenger.passenger_flights.destroy_all
    @passenger.destroy
    redirect_to flights_path
  end
end