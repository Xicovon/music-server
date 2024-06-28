require "test_helper"

class DownloadQueueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get download_queue_index_url
    assert_response :success
  end
end
