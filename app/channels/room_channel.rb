class RoomChannel < ApplicationCable::Channel

  def subscribed
    @user = User.find(params[:user_id])
    reject if @user.nil?
    @room = Room.find(params[:room_id])
    reject if @room.nil?
    stream_for(@room)
    puts "---------create subscription -----------"
    join_room(params[:room_id], params[:user_id])
  end

  def unsubscribed
    stop_all_streams
    puts "---------delete subscription -----------"
    left_room(params[:room_id], params[:user_id])
  end

private

  def join_room(room_id, user_id)
    room = Room.find(room_id)
    room.user_rooms.create!(user_id: user_id) unless room.user_rooms.exists?(user_id: user_id)
    broadcast_member(room, user_id)
  end

  def left_room(room_id, user_id)
    room = Room.find(room_id)
    connection = room.user_rooms.find_by(user_id: user_id)
    connection.destroy if connection.present?
    broadcast_member(room, user_id)
  end

  def broadcast_member(room, user_id)
    member_template = ApplicationController.renderer.render partial: 'rooms/members', locals: { users: room.users }
    player_template = ApplicationController.renderer.render partial: 'users/online', locals: { player: User.find(user_id), room: room}
    master = room.user_rooms.first
    master_id = master ? master.user_id : 0
    RoomChannel.broadcast_to(room, {member: member_template, master: master_id, player_id: user_id, player: player_template})
  end

end
