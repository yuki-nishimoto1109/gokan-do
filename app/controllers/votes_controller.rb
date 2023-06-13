class VotesController < ApplicationController

  def create
    vote = current_user.votes.create!(vote_params)
    room = Room.find(params[:room_id])
    if vote.save
      redirect_to result_room_path(room)
    else
      redirect_to vote_room_path(room)
    end
  end

private
  def vote_params
    params.require(:vote).permit(:answer_id, :round_id)
  end

end
