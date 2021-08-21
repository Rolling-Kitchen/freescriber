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
      @videos.each_with_index.map{|video, index|
        video_captions = []
        # new_result = {
        #   title: video.title,
        #   description: video.description,
        #   created_at: video.created_at,
        #   captions: []
        # }
        # if video.title.include? @search_query
        #   new_result[:title] = video.title            
        # end
        # if video.description.include? @search_query
        #   new_result[:title] = video.description
        # end
        video.captions.each_with_index.map{|caption, index| 
          if caption["text"].include? @search_query
            # create for last index or first index
            video_captions.push(video.captions[index-1]["start"] + " ..." + video.captions[index-1]["text"] + " " + caption["text"] + " " + video.captions[index-+1]["text"] + "...")
          end
        }
        @caption_results.push(video_captions)
      }
      
    else
      @videos = Video.all
    end
    unless current_page?(videos_path)
      redirect_to videos_path
    end
  end

  def show
    @video = Video.find(params[:id])
    unless @video.photo.attached?
      yt = YoutubeApi.new
      @thumbnail = yt.get_thumbnail(@video)
      file = URI.open(@thumbnail)
      @video.photo.attach(io: file, filename: 'thumbnail.png', content_type: 'image/png')
    end
    authorize @video
    if @video.captions == {}
      yt = YoutubeApi.new
      @video.captions = yt.get_captions(@video)
      @video.save
    else
      nil
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
      if hash["text"].include? params[:text_query]
        array_of_text << hash
      end
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


#   before_action :get_youtube_thumbnail

# def get_youtube_thumbnail
#   url = extract_url_from_body

#   unless url.blank?
#     client   = YouTubeIt::Client.new
#     response = client.video_by(url)
#     self.thumbnail = response.thumbnails.first.url
#   end
# end

# def extract_url_from_body
#   URI.extract(body).first
# end

end
