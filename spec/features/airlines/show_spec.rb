require 'rails_helper'

RSpec.describe 'Airlines Show Page' do
  before(:each) do
    load_test_data
    visit airline_path(@southwest)
  end

  describe 'as a visitor, when I visit the airlines show page I see' do
    it 'lists all the unique names of adult passengers that have flights from that airline' do
      expect(page).to have_content(@passenger2.name).once
      expect(page).to have_content(@passenger4.name).once

      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger7.name)
    end
  end
end