def load_airline_spec_data
  @airline = Airline.create!(name: 'Emirates')

  @flight_1 = Flight.create!(airline: @airline, number: "1111", date: "03/06/23", departure_city: 'Denver', arrival_city: 'Charlotte')
  @flight_2 = Flight.create!(airline: @airline, number: "2222", date: "03/07/23", departure_city: 'Charlotte', arrival_city: 'Denver')
  @flight_3 = Flight.create!(airline: @airline, number: "3333", date: "03/08/23", departure_city: 'Denver', arrival_city: 'Chicago')
  @flight_4 = Flight.create!(airline: @airline, number: "4444", date: "03/10/23", departure_city: 'Denver', arrival_city: 'Orlando')


  @abdul = Passenger.create!(name: "Abdul", age: 31)
  @adam = Passenger.create!(name: "Adam", age: 36)
  @chris = Passenger.create!(name: "Chris", age: 35)
  @kid = Passenger.create!(name: "Kid", age: 5)

  FlightPassenger.create!(flight: @flight_1, passenger: @adam)
  FlightPassenger.create!(flight: @flight_2, passenger: @adam)
  FlightPassenger.create!(flight: @flight_3, passenger: @adam)
  FlightPassenger.create!(flight: @flight_4, passenger: @adam)

  FlightPassenger.create!(flight: @flight_1, passenger: @abdul)
  FlightPassenger.create!(flight: @flight_2, passenger: @abdul)
  FlightPassenger.create!(flight: @flight_4, passenger: @abdul)

  FlightPassenger.create!(flight: @flight_2, passenger: @chris)
  FlightPassenger.create!(flight: @flight_3, passenger: @chris)

  FlightPassenger.create!(flight: @flight_2, passenger: @kid)
end

def load_flight_spec_data
  @airline = Airline.create!(name: 'Emirates')

  @flight_1 = Flight.create!(airline: @airline, number: "1111", date: "03/06/23", departure_city: 'Denver', arrival_city: 'Charlotte')
  @flight_2 = Flight.create!(airline: @airline, number: "2222", date: "03/07/23", departure_city: 'Charlotte', arrival_city: 'Denver')
  @flight_3 = Flight.create!(airline: @airline, number: "3333", date: "03/08/23", departure_city: 'Denver', arrival_city: 'Chicago')
  @flight_4 = Flight.create!(airline: @airline, number: "4444", date: "03/10/23", departure_city: 'Denver', arrival_city: 'Orlando')


  @abdul = Passenger.create!(name: "Abdul", age: 31)
  @adam = Passenger.create!(name: "Adam", age: 36)
  @chris = Passenger.create!(name: "Chris", age: 35)

  FlightPassenger.create!(flight: @flight_1, passenger: @adam)
  FlightPassenger.create!(flight: @flight_2, passenger: @abdul)
  FlightPassenger.create!(flight: @flight_2, passenger: @adam)
  FlightPassenger.create!(flight: @flight_2, passenger: @chris)
  FlightPassenger.create!(flight: @flight_3, passenger: @chris)
  FlightPassenger.create!(flight: @flight_4, passenger: @abdul)
end