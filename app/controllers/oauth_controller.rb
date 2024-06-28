class OauthController < ApplicationController

  def authorize
    YoutubeApi.init
    @auth_url = YoutubeApi.get_url
    @credentials = YoutubeApi.get_credentials
  end

  # The OAuth callback
  def oauth_callback
    code = (params[:code])

    YoutubeApi.set_token(code)

    @credentials = YoutubeApi.get_credentials
    # redirect_to authorize_path
  end
end
