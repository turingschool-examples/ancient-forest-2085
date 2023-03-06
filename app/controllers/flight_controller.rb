class FlightController < ApplicationController

  def index
    @flights = Flight.all
  end
end