class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.integer :round_id
      t.integer :user_id
      t.string  :content
      t.string  :hand
      t.integer :vote_to
      t.timestamps
    end
  end
end
