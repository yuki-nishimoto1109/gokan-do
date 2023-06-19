class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :round_id, null: false
      t.string  :winner
      t.string  :answer
      t.timestamps
    end
  end
end
