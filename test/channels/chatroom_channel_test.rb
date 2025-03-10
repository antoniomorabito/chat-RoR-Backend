require "test_helper"

class ChatroomChannelTest < ActionCable::Channel::TestCase
  def setup
    @chatroom = Chatroom.create!(name: "Test Room", unique_code: SecureRandom.hex(10))
  end

  test "subscribes to a valid chatroom" do
    subscribe(chatroom_id: @chatroom.unique_code)
    assert subscription.confirmed?
    assert_has_stream "chatroom_#{@chatroom.id}"
  end

  test "rejects subscription with invalid chatroom" do
    subscribe(chatroom_id: "nonexistent")
    assert_no_streams
  end

  test "broadcasts messages to chatroom stream" do
    subscribe(chatroom_id: @chatroom.unique_code)

    assert_broadcasts("chatroom_#{@chatroom.id}", 1) do
      perform(:receive, { chatroom_id: @chatroom.unique_code, content: "Hello!", sender: "Alice" })
    end
  end
end
