class PassengersController < ApplicationController
  def index
    @flights = Flight.find(params[:passenger_id])
  end

  def show
    @passenger = Passenger.find(params[:id])
  end


  def destroy
    Passenger.find(params[:flight_id, :id]).destroy
    
    redirect_to flights_path
  end
end