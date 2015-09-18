class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :origin
      t.string :destination
      t.integer :seat_count
      t.date :date
      t.time :departure_time
      t.time :return_time

      t.timestamps null: false
    end
  end
end
