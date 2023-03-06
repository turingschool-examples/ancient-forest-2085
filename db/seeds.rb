# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@airline1 = Airline.create!(name: "Delta")
@airline2 = Airline.create!(name: "United")

@flight1 = Flight.create!(number: "12345", date: "1/1/2024", departure_city: "Denver", arrival_city: "Boston", airline_id: @airline1.id)
@flight2 = Flight.create!(number: "56789", date: "1/1/2024", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: @airline1.id)

@flight3 = Flight.create!(number: "34567", date: "1/1/2024", departure_city: "Denver", arrival_city: "New York", airline_id: @airline2.id)
@flight4 = Flight.create!(number: "23456", date: "1/1/2024", departure_city: "Denver", arrival_city: "Cancun", airline_id: @airline2.id)

@passenger1 = Passenger.create(name: "Brian", age: 20)
@passenger2 = Passenger.create(name: "John", age: 18)

PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
PassengerFlight.create!(passenger: @passenger1, flight: @flight2)

PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
PassengerFlight.create!(passenger: @passenger2, flight: @flight2)