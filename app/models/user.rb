class User < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :answers, dependent: :destroy
  has_many :join_rounds, dependent: :destroy
  has_many :votes, dependent: :destroy

  def online?(room)
    user_rooms.exists?(room_id: room.id)
  end

  def join_other_room?(room)
    Room.where.not(id: room.id).each do |room|
      round = room.rounds.find_by(is_finished: false)
      return true if round && round.join_rounds.exists?(user_id: id)
    end
    return false
  end
end
