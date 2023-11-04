class AddRoomTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :room_types do |t|
      t.text :description, null: false
      t.integer :capacity, null: false
      t.decimal :price_per_night, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
