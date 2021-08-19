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
    email: 'user@user.com',
    password: "123123",
    first_name: "j",
    last_name: "crew",
    job: 1
  )
  @user.save!

@videos = ["1","2"]
# @videos.each do |video|
  
  p 'created user and creating video now'
Video.create!(
  user: @user,
  title: "LeWagon Pitches",
  description: "In Rails, an association is a connection between two Active Record models. Why do we need associations between models? Because they make common operations simpler and easier in your code. For example, consider a simple Rails application that includes a model for authors and a model for books. Each author can have many books. Without associations, the model declarations would look like this",
  video_source: "BlpttiV77HY",
  captions:{}
)

Video.create!(
  user: @user,
  title: "self intro",
  description: "In Rails, an association is a connection between two Active Record models. Why do we need associations between models? Because they make common operations simpler and easier in your code. For example, consider a simple Rails application that includes a model for authors and a model for books. Each author can have many books. Without associations, the model declarations would look like this",
  video_source: "twKuAWMQbAM",
  captions:[{"end"=>"0:00:02.800", "text"=>"all right now i'm testing this for a", "start"=>"0:00:00.320", "end_seconds"=>2.8, "start_seconds"=>0.32},
    {"end"=>"0:00:04.799", "text"=>"second time", "start"=>"0:00:01.680", "end_seconds"=>4.799, "start_seconds"=>1.68},
    {"end"=>"0:00:09.359", "text"=>"i want to see if the default language", "start"=>"0:00:02.800", "end_seconds"=>9.359, "start_seconds"=>2.8},
    {"end"=>"0:00:09.359", "text"=>"gets set when i upload a video", "start"=>"0:00:04.799", "end_seconds"=>9.359, "start_seconds"=>4.799}]
)

Video.create!(
  user: @user,
  title: "Workday Training",
  description: "In Rails, an association is a connection between two Active Record models. Why do we need associations between models? Because they make common operations simpler and easier in your code. For example, consider a simple Rails application that includes a model for authors and a model for books. Each author can have many books. Without associations, the model declarations would look like this",
  video_source: "Jf9H18-wKvU",
  captions:[{"end"=>"0:00:03.919", "text"=>"then a business object", "start"=>"0:00:00.080", "end_seconds"=>3.919, "start_seconds"=>0.08},
    {"end"=>"0:00:05.359", "text"=>"okay every flaw is a business object so", "start"=>"0:00:01.760", "end_seconds"=>5.359, "start_seconds"=>1.76},
    {"end"=>"0:00:06.960", "text"=>"for example we have the business object", "start"=>"0:00:03.919", "end_seconds"=>6.96, "start_seconds"=>3.919},
    {"end"=>"0:00:08.559", "text"=>"for the worker for journal line for", "start"=>"0:00:05.359", "end_seconds"=>8.559, "start_seconds"=>5.359},
    {"end"=>"0:00:10.080", "text"=>"expanded report so you will have", "start"=>"0:00:06.960", "end_seconds"=>10.08, "start_seconds"=>6.96},
    {"end"=>"0:00:11.440", "text"=>"thousands of the business object in", "start"=>"0:00:08.559", "end_seconds"=>11.44, "start_seconds"=>8.559},
    {"end"=>"0:00:14.000", "text"=>"workday", "start"=>"0:00:10.080", "end_seconds"=>14.0, "start_seconds"=>10.08},
    {"end"=>"0:00:15.920", "text"=>"so within each of the business object", "start"=>"0:00:11.440", "end_seconds"=>15.92, "start_seconds"=>11.44},
    {"end"=>"0:00:17.600", "text"=>"then you would want to be able to say", "start"=>"0:00:14.000", "end_seconds"=>17.6, "start_seconds"=>14.0},
    {"end"=>"0:00:19.520", "text"=>"that i want to write the report i want", "start"=>"0:00:15.920", "end_seconds"=>19.52, "start_seconds"=>15.92},
    {"end"=>"0:00:21.680", "text"=>"to actually", "start"=>"0:00:17.600", "end_seconds"=>21.68, "start_seconds"=>17.6},
    {"end"=>"0:00:23.519", "text"=>"select the data source so the data", "start"=>"0:00:19.520", "end_seconds"=>23.519, "start_seconds"=>19.52},
    {"end"=>"0:00:25.199", "text"=>"source basically is the one that helping", "start"=>"0:00:21.680", "end_seconds"=>25.199, "start_seconds"=>21.68},
    {"end"=>"0:00:27.840", "text"=>"you to link you to the business object", "start"=>"0:00:23.519", "end_seconds"=>27.84, "start_seconds"=>23.519},
    {"end"=>"0:00:29.840", "text"=>"inside the window which window you go in", "start"=>"0:00:25.199", "end_seconds"=>29.84, "start_seconds"=>25.199},
    {"end"=>"0:00:32.399", "text"=>"or which window you look into you will", "start"=>"0:00:27.840", "end_seconds"=>32.399, "start_seconds"=>27.84},
    {"end"=>"0:00:34.880", "text"=>"then be able to look at the data inside", "start"=>"0:00:29.840", "end_seconds"=>34.88, "start_seconds"=>29.84},
    {"end"=>"0:00:36.559", "text"=>"the business object so for example on", "start"=>"0:00:32.399", "end_seconds"=>36.559, "start_seconds"=>32.399},
    {"end"=>"0:00:39.120", "text"=>"the worker business object you got the", "start"=>"0:00:34.880", "end_seconds"=>39.12, "start_seconds"=>34.88},
    {"end"=>"0:00:42.079", "text"=>"worker for hcm reporting that allow you", "start"=>"0:00:36.559", "end_seconds"=>42.079, "start_seconds"=>36.559},
    {"end"=>"0:00:44.000", "text"=>"to filter the instant the employee or", "start"=>"0:00:39.120", "end_seconds"=>44.0, "start_seconds"=>39.12},
    {"end"=>"0:00:46.480", "text"=>"the worker that you want to be included", "start"=>"0:00:42.079", "end_seconds"=>46.48, "start_seconds"=>42.079},
    {"end"=>"0:00:48.960", "text"=>"or all retiree basically will only pick", "start"=>"0:00:44.000", "end_seconds"=>48.96, "start_seconds"=>44.0},
    {"end"=>"0:00:51.120", "text"=>"up the retiree employee to be included", "start"=>"0:00:46.480", "end_seconds"=>51.12, "start_seconds"=>46.48},
    {"end"=>"0:00:53.760", "text"=>"in the report so the data source is", "start"=>"0:00:48.960", "end_seconds"=>53.76, "start_seconds"=>48.96},
    {"end"=>"0:00:55.680", "text"=>"basically the start filter for us to be", "start"=>"0:00:51.120", "end_seconds"=>55.68, "start_seconds"=>51.12},
    {"end"=>"0:00:58.000", "text"=>"able to get the role of the data we want", "start"=>"0:00:53.760", "end_seconds"=>58.0, "start_seconds"=>53.76},
    {"end"=>"0:01:00.160", "text"=>"to be included in the report you may not", "start"=>"0:00:55.680", "end_seconds"=>60.16, "start_seconds"=>55.68},
    {"end"=>"0:01:02.960", "text"=>"want to include 50 000 of the row of the", "start"=>"0:00:58.000", "end_seconds"=>62.96, "start_seconds"=>58.0},
    {"end"=>"0:01:05.840", "text"=>"data in the report you only want only", "start"=>"0:01:00.160", "end_seconds"=>65.84, "start_seconds"=>60.16},
    {"end"=>"0:01:08.880", "text"=>"all the retirees in your report so you", "start"=>"0:01:02.960", "end_seconds"=>68.88, "start_seconds"=>62.96},
    {"end"=>"0:01:10.960", "text"=>"select all retiree as a data source", "start"=>"0:01:05.840", "end_seconds"=>70.96000000000001, "start_seconds"=>65.84},
    {"end"=>"0:01:15.119", "text"=>"so one business object may have multiple", "start"=>"0:01:08.880", "end_seconds"=>75.119, "start_seconds"=>68.88},
    {"end"=>"0:01:15.119", "text"=>"data source are you guys with me", "start"=>"0:01:10.960", "end_seconds"=>75.119, "start_seconds"=>70.96000000000001},
    {"end"=>"0:01:21.920", "text"=>"okay let me move on so what is the", "start"=>"0:01:18.240", "end_seconds"=>81.92, "start_seconds"=>78.24},
    {"end"=>"0:01:23.600", "text"=>"importance of the data source", "start"=>"0:01:20.080", "end_seconds"=>83.6, "start_seconds"=>80.08},
    {"end"=>"0:01:25.840", "text"=>"the importance of the data source is", "start"=>"0:01:21.920", "end_seconds"=>85.84, "start_seconds"=>81.92},
    {"end"=>"0:01:27.520", "text"=>"such that for every report you have the", "start"=>"0:01:23.600", "end_seconds"=>87.52, "start_seconds"=>83.6},
    {"end"=>"0:01:30.159", "text"=>"single data source", "start"=>"0:01:25.840", "end_seconds"=>90.15899999999999, "start_seconds"=>85.84},
    {"end"=>"0:01:31.920", "text"=>"so i say every report except composite", "start"=>"0:01:27.520", "end_seconds"=>91.92, "start_seconds"=>87.52},
    {"end"=>"0:01:33.759", "text"=>"report composite report is another", "start"=>"0:01:30.159", "end_seconds"=>93.759, "start_seconds"=>90.15899999999999},
    {"end"=>"0:01:35.680", "text"=>"report type that you can have more than", "start"=>"0:01:31.920", "end_seconds"=>95.68, "start_seconds"=>91.92},
    {"end"=>"0:01:37.600", "text"=>"one data source but the rest of the", "start"=>"0:01:33.759", "end_seconds"=>97.6, "start_seconds"=>93.759},
    {"end"=>"0:01:39.759", "text"=>"report you can have only one single data", "start"=>"0:01:35.680", "end_seconds"=>99.759, "start_seconds"=>95.68},
    {"end"=>"0:01:41.360", "text"=>"source that single data source will then", "start"=>"0:01:37.600", "end_seconds"=>101.36, "start_seconds"=>97.6},
    {"end"=>"0:01:43.439", "text"=>"determine what is the pvo for that", "start"=>"0:01:39.759", "end_seconds"=>103.439, "start_seconds"=>99.759},
    {"end"=>"0:01:46.079", "text"=>"particular report as you saw that", "start"=>"0:01:41.360", "end_seconds"=>106.07900000000001, "start_seconds"=>101.36},
    {"end"=>"0:01:48.399", "text"=>"and for the pbo basically for for the", "start"=>"0:01:43.439", "end_seconds"=>108.399, "start_seconds"=>103.439},
    {"end"=>"0:01:51.200", "text"=>"pbo when you run the report the report", "start"=>"0:01:46.079", "end_seconds"=>111.2, "start_seconds"=>106.07900000000001},
    {"end"=>"0:01:53.680", "text"=>"will display one row or for each of the", "start"=>"0:01:48.399", "end_seconds"=>113.68, "start_seconds"=>108.399},
    {"end"=>"0:01:55.040", "text"=>"instance in the pbo for every instance", "start"=>"0:01:51.200", "end_seconds"=>115.03999999999999, "start_seconds"=>111.2},
    {"end"=>"0:01:57.200", "text"=>"that you have in the pbo there will", "start"=>"0:01:53.680", "end_seconds"=>117.2, "start_seconds"=>113.68},
    {"end"=>"0:01:59.119", "text"=>"become one row of the data so for", "start"=>"0:01:55.040", "end_seconds"=>119.119, "start_seconds"=>115.03999999999999},
    {"end"=>"0:02:01.200", "text"=>"example when you run the employee over", "start"=>"0:01:57.200", "end_seconds"=>121.2, "start_seconds"=>117.2},
    {"end"=>"0:02:02.560", "text"=>"here one employee become one row of the", "start"=>"0:01:59.119", "end_seconds"=>122.56, "start_seconds"=>119.119},
    {"end"=>"0:02:05.680", "text"=>"data", "start"=>"0:02:01.200", "end_seconds"=>125.68, "start_seconds"=>121.2},
    {"end"=>"0:02:08.080", "text"=>"and occasionally you may also include or", "start"=>"0:02:02.560", "end_seconds"=>128.08, "start_seconds"=>122.56},
    {"end"=>"0:02:10.640", "text"=>"you may also use all dependent all", "start"=>"0:02:05.680", "end_seconds"=>130.64, "start_seconds"=>125.68},
    {"end"=>"0:02:12.720", "text"=>"dependent basically one employee can", "start"=>"0:02:08.080", "end_seconds"=>132.72, "start_seconds"=>128.08},
    {"end"=>"0:02:14.720", "text"=>"have more than one dependent they may", "start"=>"0:02:10.640", "end_seconds"=>134.72, "start_seconds"=>130.64},
    {"end"=>"0:02:16.720", "text"=>"have a few children they may have the", "start"=>"0:02:12.720", "end_seconds"=>136.72, "start_seconds"=>132.72},
    {"end"=>"0:02:19.040", "text"=>"spouse so these are all what we call", "start"=>"0:02:14.720", "end_seconds"=>139.04, "start_seconds"=>134.72},
    {"end"=>"0:02:21.280", "text"=>"them dependent so one employee or one", "start"=>"0:02:16.720", "end_seconds"=>141.28, "start_seconds"=>136.72},
    {"end"=>"0:02:23.120", "text"=>"worker can have multiple dependents so", "start"=>"0:02:19.040", "end_seconds"=>143.12, "start_seconds"=>139.04},
    {"end"=>"0:02:25.200", "text"=>"when you run the report and if you use", "start"=>"0:02:21.280", "end_seconds"=>145.2, "start_seconds"=>141.28},
    {"end"=>"0:02:27.360", "text"=>"the dependent as a primary business", "start"=>"0:02:23.120", "end_seconds"=>147.36, "start_seconds"=>143.12},
    {"end"=>"0:02:29.120", "text"=>"object you can see that for every", "start"=>"0:02:25.200", "end_seconds"=>149.12, "start_seconds"=>145.2},
    {"end"=>"0:02:30.319", "text"=>"dependent there will become one row of", "start"=>"0:02:27.360", "end_seconds"=>150.319, "start_seconds"=>147.36},
    {"end"=>"0:02:32.319", "text"=>"the data", "start"=>"0:02:29.120", "end_seconds"=>152.31900000000002, "start_seconds"=>149.12},
    {"end"=>"0:02:34.080", "text"=>"so dependent this will be dependent this", "start"=>"0:02:30.319", "end_seconds"=>154.07999999999998, "start_seconds"=>150.319},
    {"end"=>"0:02:36.160", "text"=>"will be dependent for every dependent", "start"=>"0:02:32.319", "end_seconds"=>156.16, "start_seconds"=>152.31900000000002},
    {"end"=>"0:02:38.239", "text"=>"that you run yeah when you run the", "start"=>"0:02:34.080", "end_seconds"=>158.239, "start_seconds"=>154.07999999999998},
    {"end"=>"0:02:40.160", "text"=>"dependent as a primary business object", "start"=>"0:02:36.160", "end_seconds"=>160.16, "start_seconds"=>156.16},
    {"end"=>"0:02:42.000", "text"=>"then for every dependent that you have", "start"=>"0:02:38.239", "end_seconds"=>162.0, "start_seconds"=>158.239},
    {"end"=>"0:02:43.360", "text"=>"you will be able to fill in the employee", "start"=>"0:02:40.160", "end_seconds"=>163.36, "start_seconds"=>160.16},
    {"end"=>"0:02:46.000", "text"=>"name as well", "start"=>"0:02:42.000", "end_seconds"=>166.0, "start_seconds"=>162.0},
    {"end"=>"0:02:48.080", "text"=>"so that is the selection of the data", "start"=>"0:02:43.360", "end_seconds"=>168.07999999999998, "start_seconds"=>163.36},
    {"end"=>"0:02:50.160", "text"=>"source", "start"=>"0:02:46.000", "end_seconds"=>170.16, "start_seconds"=>166.0},
    {"end"=>"0:02:52.560", "text"=>"they are at this moment i mentioned to", "start"=>"0:02:48.080", "end_seconds"=>172.56, "start_seconds"=>168.07999999999998},
    {"end"=>"0:02:53.840", "text"=>"you two ah by the way one thing i want", "start"=>"0:02:50.160", "end_seconds"=>173.84, "start_seconds"=>170.16},
    {"end"=>"0:02:56.000", "text"=>"to mention to you", "start"=>"0:02:52.560", "end_seconds"=>176.0, "start_seconds"=>172.56},
    {"end"=>"0:02:58.319", "text"=>"the data source is also controlling the", "start"=>"0:02:53.840", "end_seconds"=>178.31900000000002, "start_seconds"=>173.84},
    {"end"=>"0:02:59.920", "text"=>"security for the report sharing and i", "start"=>"0:02:56.000", "end_seconds"=>179.92000000000002, "start_seconds"=>176.0},
    {"end"=>"0:03:01.360", "text"=>"mentioned that to you", "start"=>"0:02:58.319", "end_seconds"=>181.36, "start_seconds"=>178.31900000000002},
    {"end"=>"0:03:03.440", "text"=>"when you look at the data source the", "start"=>"0:02:59.920", "end_seconds"=>183.44, "start_seconds"=>179.92000000000002},
    {"end"=>"0:03:05.920", "text"=>"data source basically will control the", "start"=>"0:03:01.360", "end_seconds"=>185.92, "start_seconds"=>181.36},
    {"end"=>"0:03:07.920", "text"=>"user access to the report as well so in", "start"=>"0:03:03.440", "end_seconds"=>187.92, "start_seconds"=>183.44},
    {"end"=>"0:03:10.720", "text"=>"order for you to share the report", "start"=>"0:03:05.920", "end_seconds"=>190.72, "start_seconds"=>185.92},
    {"end"=>"0:03:12.959", "text"=>"the user must be one of the member", "start"=>"0:03:07.920", "end_seconds"=>192.959, "start_seconds"=>187.92},
    {"end"=>"0:03:15.760", "text"=>"belong to the security group that you", "start"=>"0:03:10.720", "end_seconds"=>195.76, "start_seconds"=>190.72},
    {"end"=>"0:03:15.760", "text"=>"can that have", "start"=>"0:03:12.959", "end_seconds"=>195.76, "start_seconds"=>192.959}]
)
# end

p "seed done!"