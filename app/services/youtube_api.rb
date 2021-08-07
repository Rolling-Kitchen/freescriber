  class YoutubeApi
    def initialize
      # Sample Ruby code for user authorization
      require 'rubygems'
      require 'google/apis'
      require 'google/apis/youtube_v3'
      require 'googleauth'
      require 'googleauth/stores/file_token_store'
      require 'fileutils'
      require 'json'

      # REPLACE WITH VALID redirect_uri FOR YOUR CLIENT
      redirect_uri = 'http://localhost:3000/oauth2callback'
      @application_name = 'freescriber'

      # REPLACE WITH NAME/LOCATION OF YOUR client_secrets.json FILE
      # MAKE SURE TO MAKE THIS PRIVATE LATER
      @client_secrets_path = '.client_secret.json'

      # REPLACE FINAL ARGUMENT WITH FILE WHERE CREDENTIALS WILL BE STORED
      @credentials_path = File.join(Dir.home, '.credentials',
                                  "youtube-quickstart-ruby-credentials.yaml")

      # @scope FOR WHICH THIS SCRIPT REQUESTS AUTHORIZATION
      @scope = Google::Apis::YoutubeV3::AUTH_YOUTUBE_READONLY


    end
    def channels_list_by_username(part, **params)
      # Initialize the API
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.client_options.application_name = @application_name
      service.authorization = authorize

      response = service.list_channels(part, params).to_json
      item = JSON.parse(response).fetch("items")[0]
    
      puts ("This channel's ID is #{item.fetch("id")}. " +
           "Its title is '#{item.fetch("snippet").fetch("title")}', and it has " +
            "#{item.fetch("statistics").fetch("viewCount")} views.")
    end

    private_methods
      
      def authorize
        FileUtils.mkdir_p(File.dirname(@credentials_path))

        client_id = Google::Auth::ClientId.from_file(@client_secrets_path)
        token_store = Google::Auth::Stores::FileTokenStore.new(file: @credentials_path)
        authorizer = Google::Auth::UserAuthorizer.new(
          client_id, @scope, token_store)
        user_id = 'default'
        credentials = authorizer.get_credentials(user_id)
        if credentials.nil?
          url = authorizer.get_authorization_url(base_url: redirect_uri)
          puts "Open the following URL in the browser and enter the " +
              "resulting code after authorization"
          puts url
          code = gets
          credentials = authorizer.get_and_store_credentials_from_code(
            user_id: user_id, code: code, base_url: redirect_uri)
        end
        credentials
      end
  end