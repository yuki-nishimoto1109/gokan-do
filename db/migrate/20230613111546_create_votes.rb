class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :round_id,  null: false
      t.integer :user_id,   null: false
      t.integer :answer_id, null: false
      t.timestamps
    end
  end
end
