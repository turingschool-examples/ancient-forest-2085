class FlightPassengersController < ApplicationController
  def destroy
    FlightPassenger.destroy(params[:id])
    redirect_to flights_path, notice: "Flight passenger was successfully destroyed."
  end
end