class YoutubeApi
  def initialize
    # Sample Ruby code for user authorization
    require 'rubygems'
    require 'google/apis'
    require 'google/apis/youtube_v3'
    require 'google/cloud'
    require 'google/cloud/translate'
    require 'googleauth'
    require 'googleauth/stores/file_token_store'
    require 'fileutils'
    require 'json'

    # REPLACE WITH VALID @redirect_uri FOR YOUR CLIENT
    # @redirect_uri = 'http://localhost:3000/oauth2callback'
      @redirect_uri = 'https://freescriber.herokuapp.com/oauth2callback'
    @application_name = 'freescriber'

    # REPLACE WITH NAME/LOCATION OF YOUR client_secrets.json FILE
    # MAKE SURE TO MAKE THIS PRIVATE LATER
    @client_secrets_path = './client_secrets.json'
    # REPLACE FINAL ARGUMENT WITH FILE WHERE CREDENTIALS WILL BE STORED
    @credentials_path = Rails.root.join("public", "youtube-credentials.yaml")

    # @scope FOR WHICH THIS SCRIPT REQUESTS AUTHORIZATION
    @scope = 'https://www.googleapis.com/auth/youtube.force-ssl'

    @service = Google::Apis::YoutubeV3::YouTubeService.new
    @service.client_options.application_name = @application_name
    @service.authorization = authorize
  end

  def upload_video(file, title, description)
    status = Google::Apis::YoutubeV3::VideoStatus.new(
      privacy_status: 'unlisted',
      selfDeclaredMadeForKids: false,
      embeddable: true
    )
    snippet = Google::Apis::YoutubeV3::VideoSnippet.new(
      title: title,
      description: description,
      defaultAudioLanguage: "en",
      defaultLanguage: "en"
    )
    video_object = Google::Apis::YoutubeV3::Video.new(
      status: status,
      snippet: snippet,
    )
    @service.insert_video(
      'id,snippet,status',
      video_object,
      notify_subscribers: false,
      upload_source: file,
      content_type: 'video/webm',
      options: {
        authorization: @credentials
      }
    )
  end

  def get_captions(video)
    # Check if the video has captions
    result = @service.list_captions("id", video.video_source)
    # if it has captions, try to fetch them and add them to the video model
    if result.items.length >0
      caption_id = result.items[0].id      
      captions_string = @service.download_caption(caption_id)
      captions_lines = captions_string.split("\n\n")
      captions = captions_lines.map do |line| 
        line_array = line.split("\n")
        {
          start: line_array[0].split(",")[0],
          end: line_array[0].split(",")[1],
          text: line_array[1],
          start_seconds: line_array[0].split(",")[0].split(':').map(&:to_f).inject(0) { |a, b| a * 60 + b },
          end_seconds: line_array[0].split(",")[1].split(':').map(&:to_f).inject(0) { |a, b| a * 60 + b }
        }
      end
      p "I've fetched the captions!"
      return captions
    else
      # If there are no captions, return nothing
      p "There are no captions available yet"
      return {}
    end
  end
  
  def get_thumbnail(video)
    result = @service.list_videos('snippet', id: video.video_source)
    return result.items[0].snippet.thumbnails.high.url
  end

  def get_duration(video)
    result = @service.list_videos('contentDetails', id: video.video_source)
    p "duration"
    p result.items[0].content_details.duration
    return ActiveSupport::Duration.parse(result.items[0].content_details.duration).in_minutes
    raise
  end

  def translate(video, language)
    @service = Google::Cloud::Translate.translation_service do |config|
      config.credentials = "./credential.json"
    end
    @translation = @service.translate_text({
      "contents": video.captions.map{|caption| caption['text']},
      "source_language_code": "en", 
      "target_language_code": language,
      "parent": "projects/freescriber"
    })
    return @translation.translations.map{ |translation| translation.translated_text }
  end

  private
    
    def authorize
      FileUtils.mkdir_p(File.dirname(@credentials_path))

      client_id = Google::Auth::ClientId.from_file(@client_secrets_path)
      p "credentials path"
      p @credentials_path
      p "clientsecrets path"
      p @client_secrets_path
      @token_store = Google::Auth::Stores::FileTokenStore.new(file: @credentials_path)
      p "token store path"
      p @token_store
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, @scope, @token_store)
      user_id = 'default'
      @credentials = authorizer.get_credentials(user_id)
      p @credentials
      if @credentials.nil?
        url = authorizer.get_authorization_url(base_url: @redirect_uri)
        puts "Open the following URL in the browser and enter the " +
            "resulting code after authorization"
        puts url
        code = ENV['YOUTUBE_TOKEN']
        # code = gets
        # code = ENV['YOUTUBE_TOKEN']
      
        @credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: @redirect_uri)
          p @credentials
      end
      @credentials
    end
end
