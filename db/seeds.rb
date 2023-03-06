# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@airline = Airline.create!(name: "Frontier")
@flight_1 = @airline.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
@flight_2 = @airline.flights.create!(number: "1728", date: "08/04/20", departure_city: "Reno", arrival_city: "Denver")
@flight_3 = @airline.flights.create!(number: "1729", date: "08/05/20", departure_city: "Denver", arrival_city: "Las Vegas")
@passenger_1 = Passenger.create!(name: "Sally Peach", age: 25)
@passenger_2 = Passenger.create!(name: "Tomato Jones", age: 35)
@passenger_3 = Passenger.create!(name: "Sandy Smith", age: 45)
FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
FlightPassenger.create!(flight: @flight_1, passenger: @passenger_2)
FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
FlightPassenger.create!(flight: @flight_2, passenger: @passenger_3)
FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)