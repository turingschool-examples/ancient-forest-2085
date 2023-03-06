class AirlinesController < ApplicationController

  def show 
    @airline = Airline.find(params[:id])
    @unique_list = @airline.unique_list_adults
  end
  
end 
