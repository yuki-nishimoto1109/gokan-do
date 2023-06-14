class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :rounds

  def latest_round
    round = rounds.find_by(is_finished: false)
    unless round.present?
      # create new_round
      round = rounds.new()
      round.theme = Theme.all.map{|c| c.content}.sample(1)[0]
      round.save
      # record start_member
      users.each do |user|
        round.join_rounds.create!(user_id: user.id)
      end
    end
    return round
  end
end
