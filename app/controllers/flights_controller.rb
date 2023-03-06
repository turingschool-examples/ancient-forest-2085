class FlightsController < ApplicationController
  def index
    @flights = Flight.all.distinct
  end
end