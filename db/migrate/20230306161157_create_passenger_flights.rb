class CreatePassengerFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :passenger_flights do |t|
      t.belongs_to :passenger
      t.belongs_to :flight

      t.timestamps
    end
  end
end
