class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.integer :room_id
      t.integer :condition
      t.string  :theme
      t.boolean :is_finished, default: false
      t.timestamps
    end
  end
end
