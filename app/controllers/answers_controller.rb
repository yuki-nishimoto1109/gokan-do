class AnswersController < ApplicationController

  def update
    answer = Answer.find(params[:id])
    room = Room.find(params[:answer][:room_id])
    if answer.update(answer_params)
      RoomChannel.broadcast_to(room, {answer: answer.content, player_id: answer.user.id})
      redirect_to vote_room_path(room)
    else
      redirect_to answer_room_path(room)
    end
  end

private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
