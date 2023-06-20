class User < ApplicationRecord

  has_many :user_rooms,   dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :answers,      dependent: :destroy
  has_many :join_rounds,  dependent: :destroy
  has_many :votes,        dependent: :destroy

  def online?(room)
    user_rooms.exists?(room_id: room.id)
  end

  def join_other_room?(room)
    Round.where.not(room_id: room.id).where(is_finished: false).each do |round|
      return true if round.join_rounds.exists?(user_id: id)
    end
    return false
  end

end
