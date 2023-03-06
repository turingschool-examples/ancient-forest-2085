require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  before(:each) do
    ## All data is created in helper_methods.rb ##
    load_test_data
    visit flights_path
  end
  
  it 'displays all flight numbers and the airline of the flight' do
    expect(page).to have_content(@sw_flight1.number)
    expect(page).to have_content(@sw_flight1.airline.name)
    expect(page).to have_content(@sw_flight2.number)
    expect(page).to have_content(@sw_flight2.airline.name)
    expect(page).to have_content(@sw_flight3.number)
    expect(page).to have_content(@sw_flight3.airline.name)
    expect(page).to have_content(@f_flight1.number)
    expect(page).to have_content(@f_flight1.airline.name)
    expect(page).to have_content(@f_flight2.number)
    expect(page).to have_content(@f_flight2.airline.name)
    expect(page).to have_content(@f_flight3.number)
    expect(page).to have_content(@f_flight3.airline.name)
  end

  it 'lists the names of all passengers on that flight' do
    within "#flight-#{@sw_flight1.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)
      expect(page).to have_content(@passenger3.name)
    end

    within "#flight-#{@sw_flight2.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger4.name)
    end

    within "#flight-#{@sw_flight3.id}" do
      expect(page).to have_content(@passenger5.name)
    end

    within "#flight-#{@f_flight1.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger6.name)
    end

    within "#flight-#{@f_flight2.id}" do
      expect(page).to have_content(@passenger2.name)
      expect(page).to have_content(@passenger3.name)
      expect(page).to have_content(@passenger4.name)
    end

    within "#flight-#{@f_flight3.id}" do
      expect(page).to have_content(@passenger6.name)
    end
  end

  it 'has a button to remove a passenger from a flight' do
    within "#flight-#{@sw_flight1.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_link("Remove #{@passenger1.name}")
    end

    within "#flight-#{@sw_flight2.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_link("Remove #{@passenger1.name}")
      click_link("Remove #{@passenger1.name}")

    end
    expect(current_path).to eq(flights_path)

    within "#flight-#{@f_flight1.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_link("Remove #{@passenger1.name}")
    end

    within "#flight-#{@sw_flight2.id}" do
      expect(page).to_not have_content(@passenger1.name)
    end
  end
end