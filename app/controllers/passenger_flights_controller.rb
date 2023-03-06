class PassengerFlightsController < ApplicationController

  def destroy
    @flight = Flight.find(params[:id])
    @passenger = Passenger.find(params[:id])
    @passenger_flight = @passenger.destroy
  end

end