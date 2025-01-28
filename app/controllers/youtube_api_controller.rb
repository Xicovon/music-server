class YoutubeApiController < ApplicationController
  def show
    @authenticate_url = YoutubeApi.get_url
    @code = YoutubeApi.get_service.authorization&.code
  end
end
