class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.integer :round_id, null: false
      t.integer :user_id,  null: false
      t.string  :content
      t.string  :hand
      t.timestamps
    end
  end
end
