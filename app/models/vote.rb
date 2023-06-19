class Vote < ApplicationRecord
  belongs_to :round
  belongs_to :user
  belongs_to :answer

  after_create_commit :make_result

private

  def make_result
    return if round.results.present?
    return if round.join_rounds.count != round.votes.count
    hash = round.votes.group(:answer_id).count
    max_val = hash.max_by{|x|x[0]}[1]
    winner_ids = hash.select{|k,v| v==max_val}.keys
    Answer.find(winner_ids).each do |answer|
      round.results.create!(
        winner: answer.user.name,
        answer: answer.content
      )
    end
    result_template = ApplicationController.renderer.render partial: 'rooms/result', locals: { results: round.results }
    RoomChannel.broadcast_to(round.room, {result: result_template})
  end

end
