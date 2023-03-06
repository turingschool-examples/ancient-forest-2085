class FlightsController < ApplicationController

  def index
    @all_flights = Flight.all
  end
end