class AirlineController < ApplicationController

  def show
    @airline = Airline.find(params[:id])
  end
end