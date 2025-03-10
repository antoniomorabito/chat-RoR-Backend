require "test_helper"

class ChatroomsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @chatroom = Chatroom.create(name: "Test Chatroom")
  end

  test "should create chatroom" do
    post chatrooms_path, params: { chatroom: { name: "New Chatroom" } }, as: :json
    assert_response :created

    response_json = JSON.parse(response.body)
    assert_equal "New Chatroom", response_json["chatroom"]["name"]
  end

  test "should show chatroom" do
    get chatroom_url(@chatroom.unique_code), as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal "Test Chatroom", json_response["name"]
  end

  test "should return error if chatroom not found" do
    get chatroom_url("non_existing_id"), as: :json
    assert_response :not_found
  
    puts response.body  
    json_response = JSON.parse(response.body)
    assert_equal "Chatroom not found", json_response["error"]
  end
  
end
