# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print "---------- make: Room ".ljust(30) + "----------"
  20.times do |n|
    Room.create!(name: "ROOM#{n+1}")
  end
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

puts " <<< FINISH >>> "
