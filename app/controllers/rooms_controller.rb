class RoomsController < ApplicationController

  before_action :require_login
  before_action :set_room,      except: [:index]
  before_action :room_player?,  except: [:index, :new]

  def index
    @rooms = Room.all
  end

  def start
    @round = @room.rounds.find_by(is_finished: false)
    return redirect_to answer_room_path(@room) if @round.present?
  end

  def new
    ActiveRecord::Base.transaction do
      # create new_round
      round = @room.rounds.new()
      round.theme = Theme.all.map{|c| c.content}.sample(1)[0]
      round.save!
      # record start_member
      @room.users.each do |user|
        round.join_rounds.create!(user_id: user.id)
        answer = round.answers.new(user_id: user.id)
        answer.hand = select_hands
        answer.save!
      end
    end
      RoomChannel.broadcast_to(@room, {start: "../../rooms/#{@room.id}/answer"})
  rescue
    flash[:danger] = "Cant start game. Try again."
    redirect_to start_room_path(@room)
  end

  def answer
    @round = @room.rounds.find_by(is_finished: false)
    return redirect_to start_room_path(@room) unless @round.present?
    @answer = @round.answers.find_by(user_id: current_user.id)
    return redirect_to vote_room_path(@room) if @answer && @answer.content.present?
    @players = @round.users
  end

  def vote
    @round = @room.rounds.find_by(is_finished: false)
    return redirect_to start_room_path(@room) unless @round.present?
    return redirect_to result_room_path(@room) if @round.votes.find_by(user_id: current_user.id).present?
    @answers = @round.answers
    @players = @round.users
    @vote = Vote.new()
  end

  def result
    @round = @room.rounds.find_by(is_finished: false)
    return redirect_to start_room_path(@room) unless @round.present?
    @results = @round.results
    @players = @round.users
  end

  def finish
    round = @room.rounds.where(is_finished: false)
    if round.present?
      round.update_all(is_finished: true)
      @room.user_rooms.destroy_all
    end
    RoomChannel.broadcast_to(@room, {start: "../../rooms"})
    return redirect_to rooms_path
  end

private

  def set_room
    @room = Room.find(params[:id])
  end

  # ゲーム開始後、参加プレイヤー以外は入室不可
  def room_player?
    if current_user.join_other_room?(@room)
      # ユーザーに他のルームでの進行中のゲームがある場合、入室不可
      flash[:danger] = "他のルームで進行中のゲームがあります。"
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

  def select_hands
    hiraganas = [*'あ'..'ん']
    result = hiraganas.sample(10).join()
    return result
  end

end
