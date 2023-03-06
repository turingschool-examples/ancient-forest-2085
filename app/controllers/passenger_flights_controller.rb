class PassengerFlightsController< ApplicationController

  def destroy
    passenger = Passenger.find(params[:passenger_id])
    flight = passenger.flights.find(params[:flight_id])
    passenger.flights.delete(flight)
    redirect_to '/flights'
  end
end