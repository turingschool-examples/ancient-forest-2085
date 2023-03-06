class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @passengers = @airline.distinct_adult_passengers
  end
end