class AddStatusToPassengerFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :passenger_flights, :status, :integer, default: 0
  end
end
