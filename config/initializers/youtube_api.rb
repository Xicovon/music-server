class YoutubeApi
  require 'rubygems'
  require 'google/apis'
  require 'google/apis/youtube_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'

  require 'fileutils'
  require 'json'

  USER_ID = 'default'
  REDIRECT_URI = 'https://xicovon.xyz'
  APPLICATION_NAME = 'Xicovon\'s Music Downloader'

# REPLACE WITH NAME/LOCATION OF YOUR client_secrets.json FILE
  CLIENT_SECRETS_PATH = File.join(Dir.home, '.credentials', 'youtube_credentials.json')

# REPLACE FINAL ARGUMENT WITH FILE WHERE CREDENTIALS WILL BE STORED
  CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "youtube_credentials.yaml")

# SCOPE FOR WHICH THIS SCRIPT REQUESTS AUTHORIZATION
  SCOPE = Google::Apis::YoutubeV3::AUTH_YOUTUBE

  @@service = Google::Apis::YoutubeV3::YouTubeService.new
  @@authorizer = nil
  @@url = nil

  def self.init
    @@service.client_options.application_name = APPLICATION_NAME

    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    @@authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)

    credentials = @@authorizer.get_credentials(USER_ID)
    credentials.redirect_uri = REDIRECT_URI

    if credentials.nil?
      @@url = @@authorizer.get_authorization_url(base_url: REDIRECT_URI)
    else
      @@service.authorization = credentials
    end
  end

  def self.get_service
    return @@service
  end

  def self.get_url
    return @@url
  end

  def self.set_token(code)
    @@service.authorization = @@authorizer.get_and_store_credentials_from_code(user_id: USER_ID, code: code, base_url: REDIRECT_URI)
  end

  def self.get_credentials
    return @@service.authorization
  end

  def self.list_playlist_items(playlist_id, next_page_token)
    response = @@service.list_playlist_items(
        'snippet,contentDetails',
        playlist_id: playlist_id,
        max_results: 50,
        page_token: next_page_token,
        options: { authorization: get_credentials }
    ).to_json

    return JSON.parse(response)
  end

  def self.list_video_by_id(video_id)
    response = @@service.list_videos(
      'snippet',
      id: video_id,
      options: { authorization: get_credentials }
    ).to_json

    return JSON.parse(response)
  end

  def self.delete_playlist_item(item_id)
    response = @@service.delete_playlist_item(
      item_id,
      options: { authorization: get_credentials }
    ).to_json

    return JSON.parse(response)
  end
end

YoutubeApi.init
