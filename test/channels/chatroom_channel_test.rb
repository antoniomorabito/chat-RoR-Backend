require "test_helper"

class ChatroomChannelTest < ActionCable::Channel::TestCase
  setup do
    @chatroom = Chatroom.create(name: "Test Room", unique_code: "test123")
  end

  test "subscribes to chatroom stream" do
    subscribe(chatroom_id: @chatroom.unique_code)

    assert subscription.confirmed? 
    assert_has_stream "chatroom_#{@chatroom.id}" 
  end

  test "does not subscribe with invalid chatroom" do
    subscribe(chatroom_id: "nonexistent")

    assert subscription.rejected? 
  end

  test "broadcasts messages to chatroom stream" do
    subscribe(chatroom_id: @chatroom.unique_code)

    message_data = { chatroom_id: @chatroom.unique_code, content: "Hello!", sender: "Alice" }
    perform :receive, message_data

    assert_broadcast_on("chatroom_#{@chatroom.id}", message_data) 
  end
end
