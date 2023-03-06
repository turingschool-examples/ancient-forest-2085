# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@united_airlines = Airline.create!(name: "United Airlines")
@fiji_air = Airline.create!(name: "Fiji Air")

@paris = @united_airlines.flights.create!(number: "1345", date: "02/02/22", departure_city: "Phoenix", arrival_city: "Paris")
@melbourne = @united_airlines.flights.create!(number: "1499", date: "06/26/14", departure_city: "Suva", arrival_city: "Melbourne")
@suva = @fiji_air.flights.create!(number: "375", date: "06/01/14", departure_city: "Washington DC", arrival_city: "Suva")    

@abdul = Passenger.create!(name: "Abdul", age: 22)
@chris = Passenger.create!(name: "Chris", age: 14)
@jamison = Passenger.create!(name: "Jamison", age: 22)
@dani = Passenger.create!(name: "Dani", age: 22)

FlightPassenger.create!(flight: @paris, passenger: @chris)
FlightPassenger.create!(flight: @paris, passenger: @abdul)

FlightPassenger.create!(flight: @melbourne, passenger: @abdul)
FlightPassenger.create!(flight: @melbourne, passenger: @dani)

FlightPassenger.create!(flight: @suva, passenger: @jamison)    

