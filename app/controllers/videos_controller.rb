class VideosController < ApplicationController
    before_action :set_video, only: [:show, :edit, :update, :destroy]

    def index
      # Policy scope - defaults to resolve.all and shows all.
      @videos = policy_scope(Video)
      if params[:query].present?
        @videos = Video.search_by_location_and_name(params[:query])
      else
        @videos = Video.all
      end
    end
  
    def show
      @subtitle = Subtitle.new()    
      authorize @video
    end
    
    def create
      @video= Video.new(video_params)
      @video.user = current_user
      if @video.save!
        redirect_to video_path(@video)
      else
        render :new
      end
      authorize @video
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
  