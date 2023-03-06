class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    # @flight_passengers = @flight.list_of_passengers
  end

  def destroy
    flight = Flight.destroy(params[:id])
    passenger = flight.passengers.find(params[:passenger_id]).destroy
    redirect_to "/flights"
  end
end