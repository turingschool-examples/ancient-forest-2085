class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @adult_passengers = Passenger.adult_passengers_sorted(@airline)
  end
end