class AirlinesController < ApplicationController

  def show
    @airline = Airline.find(params[:id])
    @uniq_passengers = @airline.uniq_passengers_list
  end
end
