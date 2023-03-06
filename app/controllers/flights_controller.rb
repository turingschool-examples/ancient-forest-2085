class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    # binding.pry
  end
end