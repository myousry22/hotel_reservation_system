class CreateReservationsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :user, foreign_key: true, index: false
      t.references :room_type, foreign_key: true, index: false

      t.timestamps
    end

    add_index :reservations, [:user_id, :room_type_id, :start_date, :end_date], 
              unique: true, name: 'unique_reservations_index'
  end
end
