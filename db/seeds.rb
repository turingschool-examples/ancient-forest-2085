# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@airline_1 = Airline.create(name: "United Airlines")
@airline_2 = Airline.create(name: "Alaska Airlines")

@flight_1 = @airline_1.flights.create(number: "3767", date: "03/05/2023", departure_city: "Los Vegas", arrival_city: "Orlando")
@flight_2 = @airline_1.flights.create(number: "7364", date: "03/04/2023", departure_city: "Missoula", arrival_city: "Denver")
@flight_3 = @airline_2.flights.create(number: "8765", date: "03/03/2023", departure_city: "Jakson", arrival_city: "Charlotte")

@passenger_1 = Passenger.create(name: "Tom", age: 65)
@passenger_2 = Passenger.create(name: "Sarah", age: 42)
@passenger_3 = Passenger.create(name: "Frank", age: 12)
@passenger_4 = Passenger.create(name: "Antonio", age: 29)
@passenger_5 = Passenger.create(name: "Enid", age: 30)

PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight_1.id)
PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_1.id)
PassengerFlight.create(passenger_id: @passenger_3.id, flight_id: @flight_2.id)
PassengerFlight.create(passenger_id: @passenger_4.id, flight_id: @flight_2.id)
PassengerFlight.create(passenger_id: @passenger_5.id, flight_id: @flight_3.id)
