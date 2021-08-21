# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' , :seconds=>0}, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   user = User.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

p 'creating user'

User.destroy_all
Video.destroy_all

 @user = User.new(
    email: 'riley@user.com',
    password: "123123",
    first_name: "riley",
    last_name: "masu",
    job: 1
  )
  @user.save!

  p 'created user and creating video now'

Video.create!(
  user: @user,
  title: "Sampling Plans 1",
  description: "",
  video_source: "43ayrCEq4ro",
  captions:{}
)
Video.create!(
  user: @user,
  title: "Process Capability1",
  description: "",
  video_source: "O84Sccz3StI",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Six Sigma Capability",
  description: "",
  video_source: "FyogxfULUoE",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Tolerance Design Part 1",
  description: "",
  video_source: "pvZt1l_wwzM",
  captions:{}
)
Video.create!(
  user: @user,
  title: "FMEA Example",
  description: "",
  video_source: "tUK_UZMTdBY",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Just In Time and the Push:Pull Concept part 1",
  description: "",
  video_source: "aEqx8kagj3w",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Just In Time and the Push:Pull Concept part 2",
  description: "",
  video_source: "4A5LwHGWVdU",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Scheduling Pull Systems",
  description: "",
  video_source: "6koBJnRrqrY",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Mixed Model Production Heijunka part 1",
  description: "",
  video_source: "sJR-8hahNuY",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Mixed Model Production Heijunka part 2",
  description: "",
  video_source: "IXDHi3Y9N8o",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Mixed Model Production Heijunka part 2",
  description: "",
  video_source: "GKxtwk5xrAM",
  captions:{}
)

Video.create!(
  user: @user,
  title: "Realizing Pull Scheduling Kanban part 2",
  description: "",
  video_source: "rY5fvnfgMKk",
  captions:{}
)

p "seed done!"
