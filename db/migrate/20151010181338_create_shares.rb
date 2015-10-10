class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :user, index: true, foreign_key: true
      t.references :ride, index: true, foreign_key: true
      t.boolean :driver

      t.timestamps null: false
    end
  end
end
