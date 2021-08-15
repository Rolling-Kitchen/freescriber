class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]

  def index
    # Policy scope - defaults to resolve.all and shows all.
    @videos = Video.all
  end

  def show
    @video
    # raise
    if @video.captions === {}
      yt = YoutubeApi.new
      @video.captions = yt.get_captions(@video)
      @video.save
    else
      nil
    end
  end

  def create
    # Make an API call to the YouTube API.
    yt = YoutubeApi.new
    video = yt.upload_video(
      params[:video][:video_file].to_path,
      params[:video][:title],
      params[:video][:description]
    )
    @video = Video.new(video_params)
    @video.user = current_user
    @video.video_source = video.id
    @video.captions = {}
    if @video.save!
      redirect_to videos_path
    else
      render :new
    end
  end

  def new
    @video = Video.new
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description)
  end
end
