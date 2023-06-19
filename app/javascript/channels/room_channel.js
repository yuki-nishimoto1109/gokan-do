/* global $*/
import consumer from "./consumer"

const channel_name = "RoomChannel"

$(document).on("turbolinks:load",function(){
  const data = $("#data").data();
  if(data==null){
    // delete subscriptions
    const subscriptions = consumer.subscriptions.subscriptions;
    if(subscriptions.length > 0){
      subscriptions.map((subscription)=>{subscription.unsubscribe()})
    };
  } else {
    const room_id = data.roomId;
    const user_id = data.userId;
    if(isSubscribed(room_id,user_id)){return};

    // make subscription
    appRoom(room_id, user_id);
  };
});

const appRoom = (room_id, user_id) => consumer.subscriptions.create(
  {channel: channel_name, room_id: room_id, user_id: user_id}, {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    console.log(data);
    if(data['start']){window.location.href = data['start'];};
    console.log(data['master']);
    console.log(data['master']==user_id);
    console.log(data['master']===user_id);
    if(data['master']==user_id){$("#start-button").show()} else {$("#start-button").hide()};
    $("#members").html(data['member']);
    $("#results").html(data['result']);
    $("#player-"+data['player_id']).html(data['player']);
    $("#answer-"+data['player_id']).html(data['answer'])
  }
});

const isSubscribed = (room_id, user_id) => {
  const identifier = `{"channel":"${channel_name}","room_id":${room_id},"user_id":${user_id}}`
  const subscription = consumer.subscriptions.findAll(identifier)
  return !!subscription.length
}