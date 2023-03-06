# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@sky = Airline.create!(name: "Sky High")
@rickety = Airline.create!(name: "Rickety Airlines")

@one = @sky.flights.create!(number: 101, date: "01/01/2021", departure_city: "Denver", arrival_city: "New York")
@two = @sky.flights.create!(number: 150, date: "02/01/2021", departure_city: "Portland", arrival_city: "Pittsburgh")
@three = @rickety.flights.create!(number: 200, date: "03/01/2021", departure_city: "Seattle", arrival_city: "San Francisco")
@four = @rickety.flights.create!(number: 250, date: "04/01/2021", departure_city: "Miami", arrival_city: "Los Angeles")

@brad = Passenger.create!(name: "Brad", age: 34)
@jeff = Passenger.create!(name: "Jeff", age: 35)
@joe = Passenger.create!(name: "Joe", age: 36)
@jim = Passenger.create!(name: "Jim", age: 37)
@jane = Passenger.create!(name: "Jane", age: 38)
@jill = Passenger.create!(name: "Jill", age: 39)
@jimmy = Passenger.create!(name: "Jimmy", age: 40)
@jenny = Passenger.create!(name: "Jenny", age: 41)

@passflight1 = PassengerFlight.create!(passenger: @brad, flight: @one)
@passflight2 = PassengerFlight.create!(passenger: @jeff, flight: @one)
@passflight3 = PassengerFlight.create!(passenger: @joe, flight: @two)
@passflight4 = PassengerFlight.create!(passenger: @jim, flight: @two)
@passflight5 = PassengerFlight.create!(passenger: @jane, flight: @three)
@passflight6 = PassengerFlight.create!(passenger: @jill, flight: @three)
@passflight7 = PassengerFlight.create!(passenger: @jimmy, flight: @four)
@passflight8 = PassengerFlight.create!(passenger: @jenny, flight: @four)
@passflight9 = PassengerFlight.create!(passenger: @brad, flight: @two)
