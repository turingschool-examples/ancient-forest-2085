# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

united = Airline.create!(name: 'United')
frontier = Airline.create!(name: 'Frontier')

flight_1 = united.flights.create!(number: 1727, date: '08/30/22', departure_city: 'Denver', arrival_city: 'Reno')
flight_2 = united.flights.create!(number: 1832, date: '08/30/22', departure_city: 'Los Angeles', arrival_city: 'Austin')
flight_3 = united.flights.create!(number: 1655, date: '08/30/22', departure_city: 'Phoenix', arrival_city: 'Las Vegas')
flight_4 = frontier.flights.create!(number: 1726, date: '08/30/22', departure_city: 'New York', arrival_city: 'Seattle')
flight_5 = frontier.flights.create!(number: 1690, date: '08/30/22', departure_city: 'Portland', arrival_city: 'San Diego')

passenger_1 = Passenger.create!(name: 'Joe', age: 30)
passenger_2 = Passenger.create!(name: 'Mary', age: 25)
passenger_3 = Passenger.create!(name: 'John', age: 25)
passenger_4 = Passenger.create!(name: 'Michael', age: 25)
passenger_5 = Passenger.create!(name: 'Henry', age: 25)
passenger_6 = Passenger.create!(name: 'David', age: 25)
passenger_7 = Passenger.create!(name: 'Valerie', age: 25)


FlightPassenger.create!(flight: flight_1, passenger: passenger_1)
FlightPassenger.create!(flight: flight_2, passenger: passenger_2)
FlightPassenger.create!(flight: flight_3, passenger: passenger_3)
FlightPassenger.create!(flight: flight_3, passenger: passenger_4)
FlightPassenger.create!(flight: flight_5, passenger: passenger_5)
FlightPassenger.create!(flight: flight_5, passenger: passenger_6)
FlightPassenger.create!(flight: flight_5, passenger: passenger_7)