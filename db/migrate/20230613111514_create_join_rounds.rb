class CreateJoinRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :join_rounds do |t|
      t.integer :user_id
      t.integer :round_id
      t.timestamps
    end
  end
end
