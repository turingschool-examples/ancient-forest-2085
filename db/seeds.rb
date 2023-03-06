# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@frontier = Airline.create!(name: "Frontier")
@united = Airline.create!(name: "United Airlines")
@delta = Airline.create!(name: "Delta Airlines")

w = Date.new(2023, 3, 6)
x = Date.new(2023, 3, 7)
y = Date.new(2023, 3, 8)
z = Date.new(2023, 3, 9)

@f1 = @frontier.flights.create!(number: 1, date: w, departure_city: "Denver", arrival_city: "Los Angeles")
@f2 = @frontier.flights.create!(number: 6, date: x, departure_city: "Denver", arrival_city: "San Diego")
@f3 = @united.flights.create!(number: 5, date: w, departure_city: "Denver", arrival_city: "Los Angeles")
@f4 = @united.flights.create!(number: 7, date: y, departure_city: "Denver", arrival_city: "San Diego")
@f5 = @delta.flights.create!(number: 9, date: y, departure_city: "Denver", arrival_city: "Los Angeles")
@f6 = @delta.flights.create!(number: 3, date: z, departure_city: "Denver", arrival_city: "San Diego")

@p1 = @f1.passengers.create!(name: "Joe", age: 27)
@p2 = @f1.passengers.create!(name: "Tori", age: 23)
@p3 = @f2.passengers.create!(name: "Joel", age: 44)
@p4 = @f2.passengers.create!(name: "Corrie", age: 44)
@p5 = @f3.passengers.create!(name: "Amy", age: 47)
@p6 = @f4.passengers.create!(name: "Sam", age: 25)
@p7 = @f4.passengers.create!(name: "Billy", age: 25)
@p8 = @f6.passengers.create!(name: "Meghan", age: 30)

FlightPassenger.create!(flight: @f5, passenger: @p1)
FlightPassenger.create!(flight: @f5, passenger: @p2)
