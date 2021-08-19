class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]

  def index
    @videos = Video.all
    if params[:query].present?
      @videos = Video.search_by_title_or_transcript(params[:query])
    else
      @videos = Video.all
    end
  end

  def show
    @video
    yt = YoutubeApi.new
    yt.get_thumbnail(@video)
    # raise
    if @video.captions === {}
      # yt = YoutubeApi.new
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
