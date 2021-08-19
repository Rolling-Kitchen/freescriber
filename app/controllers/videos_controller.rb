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
      flash[:success] = 'Video added!'
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
