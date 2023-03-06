def load_test_data
  @southwest = Airline.create!(name: "Southwest")
  @flappy = Airline.create!(name: "Flappy Birdz")

  @sw_flight1 = @southwest.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
  @sw_flight2 = @southwest.flights.create!(number: "1728", date: "08/04/20", departure_city: "Bend", arrival_city: "Bozeman")
  @sw_flight3 = @southwest.flights.create!(number: "1729", date: "08/05/20", departure_city: "PHX", arrival_city: "NYC")
  @f_flight1 = @flappy.flights.create!(number: "1730", date: "08/06/20", departure_city: "Buenos Aires", arrival_city: "Santiago")
  @f_flight2 = @flappy.flights.create!(number: "1731", date: "08/07/20", departure_city: "La Paz", arrival_city: "Rio de Janeiro")
  @f_flight3 = @flappy.flights.create!(number: "1732", date: "08/08/20", departure_city: "Puerto Monte", arrival_city: "Barioloche")

  @passenger1 = Passenger.create!(name: "Bob", age: 7)
  @passenger2 = Passenger.create!(name: "Sally", age: 21)
  @passenger3 = Passenger.create!(name: "Jose", age: 17)
  @passenger4 = Passenger.create!(name: "Maria", age: 35)
  @passenger5 = Passenger.create!(name: "Jorge", age: 14)
  @passenger6 = Passenger.create!(name: "Sofia", age: 9)

  @sw_flight1.passengers << @passenger1
  @sw_flight1.passengers << @passenger2
  @sw_flight1.passengers << @passenger3
  @sw_flight2.passengers << @passenger1
  @sw_flight2.passengers << @passenger4
  @f_flight1.passengers << @passenger1
  @f_flight1.passengers << @passenger6
  @f_flight2.passengers << @passenger2
  @f_flight2.passengers << @passenger3
  @f_flight2.passengers << @passenger4
  @sw_flight3.passengers << @passenger5
  @f_flight3.passengers << @passenger6
  
end