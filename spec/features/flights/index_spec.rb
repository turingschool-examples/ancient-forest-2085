require 'rails_helper'

describe "As a visitor when I visit the flights index page" do
  before(:each) do
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
    @f5 = @frontier.flights.create!(number: 9, date: y, departure_city: "Denver", arrival_city: "Los Angeles")
    @f6 = @frontier.flights.create!(number: 3, date: z, departure_city: "Denver", arrival_city: "San Diego")

    @p1 = @f1.passengers.create!(name: "Joe", age: 27)
    @p2 = @f1.passengers.create!(name: "Tori", age: 23)
    @p3 = @f2.passengers.create!(name: "Joel", age: 44)
    @p4 = @f2.passengers.create!(name: "Corrie", age: 44)
    @p5 = @f3.passengers.create!(name: "Amy", age: 47)
    @p6 = @f4.passengers.create!(name: "Sam", age: 25)
    @p7 = @f4.passengers.create!(name: "Billy", age: 25)
    @p8 = @f6.passengers.create!(name: "Meghan", age: 30)

  end
  it 'I see a list of all flight numbers' do
    within "#flight-#{@f1.number}" do
      expect(page).to have_content("#{@f1.number}")
    end

    within "#flight-#{@f2.number}" do
      expect(page).to have_content("#{@f2.number}")
    end

    within "#flight-#{@f3.number}" do
      expect(page).to have_content("#{@f3.number}")
    end

    within "#flight-#{@f4.number}" do
      expect(page).to have_content("#{@f4.number}")
    end

    within "#flight-#{@f5.number}" do
      expect(page).to have_content("#{@f5.number}")
    end

    within "#flight-#{@f6.number}" do
      expect(page).to have_content("#{@f6.number}")
    end
  end

  it 'next to each flight number I see the name of the Airline of that flight' do
    within "#flight-#{@f1.number}" do
      expect(page).to have_content("#{@f1.number} - #{@frontier.name}")
    end

    within "#flight-#{@f2.number}" do
      expect(page).to have_content("#{@f2.number} - #{@fronter.name}")
    end

    within "#flight-#{@f3.number}" do
      expect(page).to have_content("#{@f3.number} - #{@united.name}")
    end

    within "#flight-#{@f4.number}" do
      expect(page).to have_content("#{@f4.number} - #{@united.name}")
    end

    within "#flight-#{@f5.number}" do
      expect(page).to have_content("#{@f5.number} - #{@delta.name}")
    end

    within "#flight-#{@f6.number}" do
      expect(page).to have_content("#{@f6.number} - #{@delta.name}")
    end
  end

  it "under each flight number I see the names of all that flight's passengers" do
    within "#flight-#{@f1.number}" do
      expect(@p1.name).to come_after("#{@f1.number} - #{@frontier.name}")
      expect(@p2.name).to come_after("#{@f1.number} - #{@frontier.name}")
    end

    within "#flight-#{@f2.number}" do
      expect(@p3.name).to come_after("#{@f1.number} - #{@frontier.name}")
      expect(@p4.name).to come_after("#{@f1.number} - #{@frontier.name}")   
    end

    within "#flight-#{@f3.number}" do
      expect(@p5.name).to come_after("#{@f1.number} - #{@frontier.name}")
    end

    within "#flight-#{@f4.number}" do
      expect(@p6.name).to come_after("#{@f1.number} - #{@frontier.name}")
      expect(@p7.name).to come_after("#{@f1.number} - #{@frontier.name}")   
    end

    within "#flight-#{@f5.number}" do
      expect(page).to have_no_content(@p1.name, @p2.name, @p3.name, @p4.name, @p5.name, @p6.name, @p7.name, @p8.name)
    end

    within "#flight-#{@f6.number}" do
      expect(@p8.name).to come_after("#{@f1.number} - #{@frontier.name}")
    end
  end
end