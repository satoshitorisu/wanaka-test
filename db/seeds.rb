# User
10.times do |index|
  no = index + 1
  user = User.create(
    username:           "user_#{no}",
    email:  "test#{no}@test.com",
    encrypted_password: "password",
    password:  "password",
	first_name:"#{no}Tanaka#{no}",
    last_name:"#{no}Taro#{no}"
  )
  user.save!
end

# Team
30.times do |index|
  no = index + 1
  team = Team.create(
    name:"Team#{no}",
    organization:"XXX",
    active_place:"XXX",
    level:"XXX",
    description:"XXX",
    team_key:SecureRandom.hex(5),
    leader:"",
    image_id: "xxx",
    established_year:2000
  )
  team.save!
end

# member
member = Member.create(team_id:1, user_id:1, admin:1, status:2).save
member = Member.create(team_id:1, user_id:2, admin:0, status:2).save
member = Member.create(team_id:1, user_id:3, admin:0, status:0).save
member = Member.create(team_id:1, user_id:4, admin:0, status:1).save
member = Member.create(team_id:1, user_id:5, admin:0, status:0).save
member = Member.create(team_id:1, user_id:5, admin:0, status:1).save
member = Member.create(team_id:1, user_id:5, admin:0, status:1).save


# schedule
2.times do |index|
no = index + 1
schedule = Schedule.create(
  title: "#{no}xxx",
  memo: "memo#{no}",
  schedule_date: "2018/5/5",
  start_time: "11:00",
  end_time: "12:00",
  place: "渋谷",
  team_id: 1
  ).save
end

# 10.times do |index|
# no = index + 1
# schedule = Schedule.create(
#   title: "#{no}xxx",
#   memo: "memo#{no}",
#   schedule_date: "2018/5/5",
#   start_time: "11:00",
#   end_time: "12:00",
#   place: "渋谷",
#   team_id: 2
#   ).save
# end



# game
	# schedule = Game.create(title: "TestTitle", memo: "memo",user_id: "2",team_id: "1").save

50.times do |i|
	schedule = Game.create(title: "TestTitle", start_time: "2018/2/2" , end_time: "2018/2/2", date_time: "2018/2/2" ,memo: "memo",user_id: "2",team_id: "2").save
end

	# schedule = Game.create(title: "TestTitle",place:"place", memo: "memo",user_id: "2",team_id: "1").save


10.times do |index|
no = index + 1
participate = Participate.create(
  schedule_id: 1,
  user_id: index,
  status: 1
  ).save
end


    # t.string "title"
    # t.string "place"
    # t.string "price"
    # t.datetime "date_time"
    # t.string "memo"
    # t.datetime "start_time"
    # t.datetime "end_time"
    # t.integer "team_id"
    # t.integer "status"
    # t.integer "user_id"




