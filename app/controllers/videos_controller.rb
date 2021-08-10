class VideosController < ApplicationController
    before_action :set_video, only: [:show, :edit, :update, :destroy]

    def index
      # Policy scope - defaults to resolve.all and shows all.
      @videos = Video.all
    end

    def show
      @subtitle = Subtitle.new()
      authorize @video
    end

    def create
      # Make an API call to the YouTube API.
      yt = YoutubeApi.new()
      video = yt.upload_video(
        params[:video][:video_file],
        "Standup from 2021-03",
        "My 5 min standup from March"
      )
      render json: video
      raise
    end

    def new
      @video = Video.new
      yt = YoutubeApi.new()
      yt.channels_list_by_username('snippet,contentDetails,statistics', for_username: 'GoogleDevelopers')

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
      params.require(:video).permit(:name, :description, :food_type, :food_price, :menu_package, :location, :photo)
    end
  end
