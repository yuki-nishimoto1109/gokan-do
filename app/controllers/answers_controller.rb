class AnswersController < ApplicationController

  def update
    answer = Answer.find(params[:id])
    room = Room.find(params[:answer][:room_id])
    if answer.update(content: params[:answer][:content])
      answer_template = ApplicationController.renderer.render partial: 'rooms/answer', locals: { answer: answer }
      RoomChannel.broadcast_to(room, {answer: answer_template, player_id: answer.user.id})
      redirect_to vote_room_path(room)
    else
      redirect_to answer_room_path(room)
    end
  end

private
  def answer_params
    params.require(:answer).permit(:content, :room_id)
  end
end
