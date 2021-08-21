require "test_helper"

class Api::VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get api_videos_search_url
    assert_response :success
  end
end
