class FlightsController < ApplicationController

  def index
    @flights = Flight.all
    @airlines = Airline.all
    @passengers = Passenger.all
  end

  def destroy
    flight_passengers = FlightPassenger.find_by(passenger_id: params[:passenger_id], flight_id: params[:id])
    flight_passengers.destroy

    redirect_to "/flights"
  end
end