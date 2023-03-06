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

    visit '/flights'
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
      expect(page).to have_content("#{@f2.number} - #{@frontier.name}")
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
      expect("#{@f1.number} - #{@frontier.name}").to appear_before(@p1.name)
      expect("#{@f1.number} - #{@frontier.name}").to appear_before(@p2.name)
    end

    within "#flight-#{@f2.number}" do
      expect("#{@f2.number} - #{@frontier.name}").to appear_before(@p3.name)
      expect("#{@f2.number} - #{@frontier.name}").to appear_before(@p4.name)   
    end

    within "#flight-#{@f3.number}" do
      expect("#{@f3.number} - #{@united.name}").to appear_before(@p5.name)
    end

    within "#flight-#{@f4.number}" do
      expect("#{@f4.number} - #{@united.name}").to appear_before(@p6.name)
      expect("#{@f4.number} - #{@united.name}").to appear_before(@p7.name)   
    end

    within "#flight-#{@f5.number}" do
      expect("#{@f5.number} - #{@delta.name}").to appear_before(@p1.name)
      expect("#{@f5.number} - #{@delta.name}").to appear_before(@p2.name)

    end

    within "#flight-#{@f6.number}" do
      expect("#{@f6.number} - #{@delta.name}").to appear_before(@p8.name)
    end
  end

  describe "Removing a passenger from a flight" do
    it "next to each passenger's name, I see a link or button to remove that passenger from that flight" do
      within "#flight-#{@f1.number}" do
        within "#passenger-#{@p1.id}" do
          expect(page).to have_button("Remove Passenger")
        end

        within "#passenger-#{@p2.id}" do
          expect(page).to have_button("Remove Passenger")
        end
      end
    end

    it "When I click on that link/button, I'm returned to the flights index page, I no longer see that passenger listed under that flight, I still see the passenger listed under the other flights they were assigned to" do
      within "#flight-#{@f1.number}" do
        within "#passenger-#{@p1.id}" do
          click_button "Remove Passenger"
        end
      end

      expect(page).to have_current_path(flights_path)
      expect(page).to have_content("Flight passenger was successfully destroyed.")

      within "#flight-#{@f1.number}" do
        expect(page).to have_no_content(@p1.name)
      end

      within "#flight-#{@f5.number}" do
        expect(page).to have_content(@p1.name)
      end

    end
  end
end