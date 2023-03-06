class PassengersController < ApplicationController
  def index
    @flights = Flight.find(params[:passenger_id])
  end
end