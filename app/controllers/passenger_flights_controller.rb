class PassengerFlightsController < ApplicationController
  def destroy
    flight = Flight.find(params[:id])
    passenger = Passenger.find(params[:id])
    flight.passengers.destroy(passenger)
    
    redirect_to flights_path
  end
end