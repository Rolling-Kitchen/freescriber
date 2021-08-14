class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]

  def index
    # Policy scope - defaults to resolve.all and shows all.
    @videos = Video.all
  end

  def show
    @video
    @captions = @video.captions
  end

  def create
    # Make an API call to the YouTube API.
    yt = YoutubeApi.new
    video = yt.upload_video(
      params[:video][:video_file].to_path,
      params[:video][:title],
      params[:video][:description]
    )
    redirect_to videos_path
  end

  def new
    @video = Video.new
  end

  def edit
    raise AuthorizationError unless @video.user == current_user && current_user.is_restaurant?

    authorize @video
  end

  def update
    raise AuthorizationError unless @video.user == current_user && current_user.is_restaurant?

    @video.update(video_params)
    redirect_to video_path(@video)
    authorize @video
  end

  def destroy
    raise AuthorizationError unless @video.user == current_user && current_user.is_restaurant?

    authorize @video
    @video.destroy
    redirect_to root_path
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :video_file, :description)
  end
end
