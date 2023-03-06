class CreateFlightPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_passengers do |t|
      t.belongs_to :flight
      t.belongs_to :passenger
      t.timestamps
    end
  end
end
