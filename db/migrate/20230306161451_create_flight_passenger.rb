class CreateFlightPassenger < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_passengers do |t|
      t.references :flight
      t.references :passenger
      t.timestamps
    end
  end
end
