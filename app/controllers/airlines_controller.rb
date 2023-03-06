class AirlinesController < ApplicationController

  def show
    @airline= Airline.find(params[:id])
    @uniq_adult_passengers = @airline.uniq_adult_passengers
  end
end