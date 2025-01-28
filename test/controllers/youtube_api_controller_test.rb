require "test_helper"

class YoutubeApiControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get youtube_api_show_url
    assert_response :success
  end
end
