class VideosController < ApplicationController
  include ActionView::Helpers::UrlHelper
  require "open-uri"
  before_action :set_video, only: %i[show edit update destroy]

  def index
    @videos = policy_scope(Video)
    if params[:query].present?
      @videos = Video.search_by_title_or_transcript(params[:query])
      @search_query = params["query"]
      @caption_results = []
      @videos.each_with_index.map do |video, _index|
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
        p video_captions
        @caption_results.push(video_captions)
      end

    else
      @videos = Video.all
    end
    redirect_to videos_path unless current_page?(videos_path)
  end

  def show
    @video = Video.find(params[:id])
    yt = YoutubeApi.new
    yt.get_thumbnail(@video)
    unless @video.description?
      @video_captions = @video.captions[0..5]
      @new_description = ""
      @video_captions.each do |caption|
        @new_description.concat(caption["text"] + " ")
      end
      @new_description.concat("...")
      @video.description = @new_description
      @video.save
    end
    unless @video.photo.attached? || @video.photo.filename.to_s = "default_thumbnail.png"
      yt = YoutubeApi.new
      begin
        @thumbnail = yt.get_thumbnail(@video)
        file = URI.open(@thumbnail)
      rescue OpenURI::HTTPError
        unless @video.photo.filename.to_s = "default_thumbnail.png"
          p "attach alternate default thumbnail"
          p file = URI.open("https://picsum.photos/200")
          @video.photo.attach(io: file, filename: 'default_thumbnail.png', content_type: 'image/png')
        end
      else
        p "attach the thumbnail found"
        @video.photo.attach(io: file, filename: 'thumbnail.png', content_type: 'image/png')
      end
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

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description)
  end
end
