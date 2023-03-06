class PassengerFlightsController < ApplicationController 
  def destroy 
    passenger_flight = PassengerFlight.find(params[:id])
    passenger_flight.delete
   
    redirect_to flights_path
  end

  private 
  def passenger_flight_params 
    params.permit(:id, :flight_id)
  end
end