# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print "---------- make: Room ".ljust(30) + "----------"
  room1 = Room.create!(name: "ROOM1")
  room2 = Room.create!(name: "ROOM2")
  room3 = Room.create!(name: "ROOM3")
  room4 = Room.create!(name: "ROOM4")
puts " Finish"

print "---------- make: Theme ".ljust(30) + "----------"
  Theme.create!(
    [
      {content: "かわいい"},
      {content: "かっこいい"},
      {content: "美しい"},
      {content: "強そう"},
      {content: "弱そう"},
      {content: "おいしそう"},
      {content: "あほそう"},
      {content: "奇妙な"},
      {content: "中二病気味"},
      {content: "セクシー"},
      {content: "キモかわいい"},
      {content: "エモい"},
      {content: "もちもち"},
      {content: "体によさそう"}
    ]
  )
puts " Finish"

print "---------- make: User ".ljust(30) + "----------"
  user1 = User.create!(name: "alpha")
  user2 = User.create!(name: "beta")
  user3 = User.create!(name: "gamma")
puts " Finish"

print "---------- make: UserRoom ".ljust(30) + "----------"
  UserRoom.create!({room_id: room1.id, user_id: user1.id})
  UserRoom.create!({room_id: room1.id, user_id: user2.id})
  UserRoom.create!({room_id: room1.id, user_id: user3.id})
puts " Finish"

puts " <<< FINISH >>> "
