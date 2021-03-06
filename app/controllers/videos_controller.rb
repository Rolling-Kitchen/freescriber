class VideosController < ApplicationController
  include ActionView::Helpers::UrlHelper
  require "open-uri"
  before_action :set_video, only: %i[show edit update destroy toggle_favorite]

  def index
    @favorite_videos = current_user.favorited_by_type('Video')
    if params[:query].present?
      @videos = policy_scope(Video).search_by_title_or_transcript(params[:query])
      @search_query = params["query"]
      @caption_results = []
      @videos.each_with_index.map do |video, index|
        video_captions = []
        video.captions.each_with_index.map do |caption, index|
          next unless caption["text"].include? @search_query

          # create for last index or first index
          case index
          when 0
            video_captions.push([video.captions[index]["start_seconds"],
                                 (video.captions[index]["start"] + " " + caption["text"] + " " + video.captions[index + 1]["text"] + "...")])
          when video.captions.length - 1
            video_captions.push([video.captions[index - 1]["start_seconds"],
                                 (video.captions[index - 1]["start"] + " ..." + video.captions[index - 1]["text"] + " " + caption["text"] + " " + video.captions[index + 1]["text"] + "...")])
          else
            video_captions.push([video.captions[index - 1]["start_seconds"],
                                 (video.captions[index - 1]["start"] + " ..." + video.captions[index - 1]["text"] + " " + caption["text"] + " " + video.captions[index + 1]["text"] + "...")])
          end
        end
        @caption_results.push(video_captions)
      end

    else
      @videos = policy_scope(Video)
    end
    redirect_to videos_path unless current_page?(videos_path)
  end

  def show
    @bookmark = Bookmark.new
    @video = Video.find(params[:id])
    yt = YoutubeApi.new
    unless @video.description?
      p "get captions"
      if  @video.captions != {}
      @video_captions = @video.captions[0..5]
      @new_description = ""
      @video_captions.each do |caption|
        @new_description.concat(caption["text"] + " ")
      end
      @new_description.concat("...")
      @video.description = @new_description
      @video.save
    end
    end
    
    unless @video.photo.attached?
      yt = YoutubeApi.new
      begin
        @thumbnail = yt.get_thumbnail(@video)
        file = URI.open(@thumbnail)
      rescue OpenURI::HTTPError
        p "no thumbnail"
      else
        p "attach the thumbnail found"
        @video.photo.attach(io: file, filename: 'thumbnail.png', content_type: 'image/png')
      end
    end

    unless @video.duration?
      yt = YoutubeApi.new
      @video.duration = yt.get_duration(@video)
      @video.save
    end

    authorize @video
    if @video.captions == {}
      yt = YoutubeApi.new
      @video.captions = yt.get_captions(@video)
      @video.save
    end
    yt = YoutubeApi.new
    if params["language"]
      language = params["language"]
      @translation = yt.translate(@video, language)
    else
      @translation = nil
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
      flash[:success] = 'Video added!'
      redirect_to videos_path
    else
      render :new
    end
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def update
    @video.update(video_params)
    redirect_to videos_path(@video)
  end

  def destroy
    @video.destroy
    redirect_to videos_path
  end

  def text_search
    set_video
    array_of_text = []
    @video.captions.each do |hash|
      array_of_text << hash if hash["text"].include? params[:text_query]
    end
    render json: array_of_text
  end

  def toggle_favorite
    current_user.favorited?(@video) ? current_user.unfavorite(@video) : current_user.favorite(@video)
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def show_favorites
    @favorites = current_user.all_favorited
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description)
  end
end