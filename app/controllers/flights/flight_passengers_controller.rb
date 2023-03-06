class Flights::FlightPassengersController < ApplicationController
  def destroy
    @passenger = Passenger.find(params[:id])
    @flight = Flight.find(params[:flight_id])
    @flight_passenger = @flight.find_flight_passenger(@passenger)
    @flight_passenger.destroy
    redirect_to flights_path
  end

  private
  def x_params
    params.permit(
      :percentage_discount,
      :quantity_threshold,
      :merchant_id
    )
  end
end