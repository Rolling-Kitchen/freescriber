# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   user = User.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

p 'creating user'

User.destroy_all
Video.destroy_all

 @user = User.new(
    email: 'user@user.com',
    password: "123123",
    first_name: "j",
    last_name: "crew",
    job: 1,
  )
  @user.save!

@videos = ["1","2"]
@videos.each do |video|
  
  p 'created user and creating video now'
Video.create!(
 user: @user,
 title: "This is a test video",
 description: "I want to see if this is working.",
 video_source: "VTUQdPZbIOM",
 captions:
  [{"end"=>"0:00:02.800", "text"=>"all right now i'm testing this for a", "start"=>"0:00:00.320", "seconds"=>0.3},
   {"end"=>"0:00:04.799", "text"=>"second time", "start"=>"0:00:01.680", "seconds"=>1.6},
   {"end"=>"0:00:09.359", "text"=>"i want to see if the default language", "start"=>"0:00:02.800", "seconds"=>2.8},
   {"end"=>"0:00:09.359", "text"=>"gets set when i upload a video", "start"=>"0:00:04.799", "seconds"=>4.8}]
)
end

p "seed done!"