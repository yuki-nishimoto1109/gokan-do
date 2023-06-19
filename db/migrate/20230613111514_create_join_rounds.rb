class CreateJoinRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :join_rounds do |t|
      t.integer :user_id,  null: false
      t.integer :round_id, null: false
      t.timestamps
    end
  end
end
