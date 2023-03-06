class PassengerFlightsController < ApplicationController
  def destroy
      binding.pry
      flight = Flight.find(params[:id])
      flight.passengers.destroy
      flight.destroy
      redirect_to '/flights'
  end
end