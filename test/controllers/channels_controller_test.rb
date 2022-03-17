require "test_helper"

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @channel = channels(:one)
  end

  test "should get index" do
    get channels_url, as: :json
    assert_response :success
  end

  test "should create channel" do
    assert_difference("Channel.count") do
      post channels_url, params: { channel: { title: @channel.title } }, as: :json
    end

    assert_response :created
  end

  test "should show channel" do
    get channel_url(@channel), as: :json
    assert_response :success
  end

  test "should update channel" do
    patch channel_url(@channel), params: { channel: { title: @channel.title } }, as: :json
    assert_response :success
  end

  test "should destroy channel" do
    assert_difference("Channel.count", -1) do
      delete channel_url(@channel), as: :json
    end

    assert_response :no_content
  end
end
