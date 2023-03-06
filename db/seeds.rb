# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@airline = Airline.create!(name: 'Emirates')

@flight_1 = Flight.create!(airline: @airline, number: "1111", date: "03/06/23", departure_city: 'Denver', arrival_city: 'Charlotte')
@flight_2 = Flight.create!(airline: @airline, number: "2222", date: "03/07/23", departure_city: 'Charlotte', arrival_city: 'Denver')
@flight_3 = Flight.create!(airline: @airline, number: "3333", date: "03/08/23", departure_city: 'Denver', arrival_city: 'Chicago')
@flight_4 = Flight.create!(airline: @airline, number: "4444", date: "03/09/23", departure_city: 'Chicago', arrival_city: 'Denver')
@flight_5 = Flight.create!(airline: @airline, number: "5555", date: "03/10/23", departure_city: 'Denver', arrival_city: 'Orlando')
@flight_6 = Flight.create!(airline: @airline, number: "6666", date: "03/11/23", departure_city: 'Orlando', arrival_city: 'Denver')

@abdul = Passenger.create!(name: "Abdul", age: 31)
@adam = Passenger.create!(name: "Adam", age: 36)
@chris = Passenger.create!(name: "Chris", age: 35)

FlightPassenger.create!(flight: @flight_2, passenger: @abdul)
FlightPassenger.create!(flight: @flight_2, passenger: @adam)
FlightPassenger.create!(flight: @flight_2, passenger: @chris)
FlightPassenger.create!(flight: @flight_5, passenger: @abdul)
FlightPassenger.create!(flight: @flight_1, passenger: @adam)
FlightPassenger.create!(flight: @flight_3, passenger: @chris)