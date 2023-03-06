class Flights::PassengersController < ApplicationController
  
  # def destroy
  #   flight = Flight.find(params[:id])
  #   passenger = flight.passengers.find(params[:passenger_id])
  #   binding.pry
  #   passenger.destroy
  #   redirect_to '/flights'

  #   #I have a flight, and the passenger I want to remove from that flight. When I call on PassengerFlight.all, I see that passenger I want to delete

  # end

  # private
  # def passenger_flight_params
  #   params.permit(:passenger_id, :flight_id)
  # end
end