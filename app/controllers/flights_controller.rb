class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    require 'pry'; binding.pry
  end
end