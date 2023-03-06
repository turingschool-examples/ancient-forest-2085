require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  describe 'As a visitor' do
    context "When I visit the flights index" do
      before :each do

        visit flight_index_path
      end

      it 'shows the merchant name' do
        expect(page).to have_content(@merchant1.name)
      end

      it 'can see a link to my merchant items index' do
        expect(page).to have_link("Items")

        click_link "Items"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/items")
      end

      it 'can see a link to my merchant invoices index' do
        expect(page).to have_link("Invoices")

        click_link "Invoices"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices")
      end

      it 'shows the names of the top 5 customers with successful transactions' do
        within("#customer-#{@customer_1.id}") do
          expect(page).to have_content(@customer_1.first_name)
          expect(page).to have_content(@customer_1.last_name)

          expect(page).to have_content(3)
        end
        within("#customer-#{@customer_2.id}") do
          expect(page).to have_content(@customer_2.first_name)
          expect(page).to have_content(@customer_2.last_name)
          expect(page).to have_content(1)
        end
        within("#customer-#{@customer_3.id}") do
          expect(page).to have_content(@customer_3.first_name)
          expect(page).to have_content(@customer_3.last_name)
          expect(page).to have_content(1)
        end
        within("#customer-#{@customer_4.id}") do
          expect(page).to have_content(@customer_4.first_name)
          expect(page).to have_content(@customer_4.last_name)
          expect(page).to have_content(1)
        end
        within("#customer-#{@customer_5.id}") do
          expect(page).to have_content(@customer_5.first_name)
          expect(page).to have_content(@customer_5.last_name)
          expect(page).to have_content(1)
        end
        expect(page).to have_no_content(@customer_6.first_name)
        expect(page).to have_no_content(@customer_6.last_name)
      end

      it "can see a section for Items Ready to Ship with list of names of items ordered and ids" do
        within("#items_ready_to_ship") do

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_1.invoice_ids)

          expect(page).to have_content(@item_2.name)
          expect(page).to have_content(@item_2.invoice_ids)

          expect(page).to have_no_content(@item_3.name)
          expect(page).to have_no_content(@item_3.invoice_ids)
        end
      end

      it "each invoice id is a link to my merchant's invoice show page " do
        expect(page).to have_link(@item_1.invoice_ids)
        expect(page).to have_link(@item_2.invoice_ids)
        expect(page).to_not have_link(@item_3.invoice_ids)

        click_link("#{@item_1.invoice_ids}", match: :first)
        expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices/#{@invoice_1.id}")
      end

      it "shows the date that the invoice was created in this format: Monday, July 18, 2019" do
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
      end

      it "sees a link to view all my discounts, clicks the link, and is brought to bulk discounts index" do
        within('div.nav-container') do
          expect(page).to have_link("Bulk Discount Options")
          click_link 'Bulk Discount Options'
        end

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id)) 
      end
    end
  end
end
