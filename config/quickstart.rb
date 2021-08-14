require 'googleauth'
require 'googleauth/stores/redis_token_store'
require "googleauth/stores/file_token_store"
require "google/apis/youtube_v3"
require 'google-id-token'
require 'dotenv'

CREDENTIALS_PATH = "credentials.json"
TOKEN_PATH = "token.yaml"
OOB_URI = "urn:ietf:wg:oauth:2.0:oob"
SCOPE = "https://www.googleapis.com/auth/youtube.force-ssl"

def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = 'default'
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts 'Open the following URL in the browser and enter the ' \
         'resulting code after authorization:\n' + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end
