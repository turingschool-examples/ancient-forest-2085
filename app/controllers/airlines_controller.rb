class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @passengers = @airline.unique_adult_passengers
  end
end