class RoomsController < ApplicationController
  before_action :require_login
  before_action :set_room, except: :index
  before_action :room_player?, except: :index

  def index
    @rooms = Room.all
  end

  def start
  end

  def answer
    @round = @room.latest_round
    @answer = @round.user_answer(current_user)
    return redirect_to vote_room_path(@room) if @answer.content.present?
    @players = @round.users
  end

  def vote
    @round = @room.latest_round
    return redirect_to result_room_path(@room) if @round.votes.find_by(user_id: current_user.id).present?

    @answers = @round.answers
    @players = @round.users
    @vote = Vote.new()
  end

  def result
    @round = @room.latest_round
    @results = @round.results
    @players = @round.users
  end

  def check

  end

  def finish
    round = @room.latest_round
    round.update(is_finished: true)
    redirect_to start_room_path(@room)
  end

private

  def set_room
    @room = Room.find(params[:id])
  end

  # ゲーム開始後、参加プレイヤー以外は入室不可
  def room_player?
    if current_user.join_other_room?(@room)
      # ユーザーに他のルームでの進行中のゲームがある場合、入室不可
      flash[:danger] = @room.name + "で進行中のゲームがあります。"
      return redirect_to rooms_path
    else
      round = @room.rounds.find_by(is_finished: false)
      if round.present?
        if round.join_rounds.exists?(user_id: current_user.id)
          # 進行中のゲームにcurrent_userが含まれる場合、入室可
        else
          flash[:danger] = @room.name + "で既にゲームが進行中です。"
          return redirect_to rooms_path
        end
      else
        # 進行中のゲームがない場合、誰でも入室可
      end
    end
  end

end
