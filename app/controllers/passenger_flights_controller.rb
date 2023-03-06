class PassengerFlightsController < ApplicationController 
  def destroy 
    passenger_flight = PassengerFlight.find(params[:id])
    passenger_flight.delete
   
    redirect_to flights_path
  end
end