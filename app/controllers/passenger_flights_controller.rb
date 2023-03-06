class PassengerFlightsController < ApplicationController

  def destroy
    pf = PassengerFlight.find_pf(params[:id], params[:flight])
    pf.first.destroy
    redirect_to '/flights'
  end
end