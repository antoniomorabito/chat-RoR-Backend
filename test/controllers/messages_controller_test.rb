require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chatroom = Chatroom.create(name: "Test Chatroom")
  end

  test "should post a message" do
    assert_difference('Message.count', 1) do
      post chatroom_messages_url(@chatroom.unique_code), 
           params: { content: "Hello World!", sender: "TestUser" }, as: :json
    end
    assert_response :created
  end

  test "should get messages for a chatroom" do
    @chatroom.messages.create(content: "First Message", sender: "User1")
    get chatroom_messages_url(@chatroom.unique_code), as: :json
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal "First Message", json_response.first["content"]
  end

  test "should return error if chatroom not found" do
    post chatroom_messages_url("invalid_id"), params: { content: "Test", sender: "User" }, as: :json
    assert_response :not_found
  end
end
