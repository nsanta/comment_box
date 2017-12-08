defmodule CommentBoxWeb.BoxChannelTest do
  use CommentBoxWeb.ChannelCase
  alias CommentBoxWeb.BoxChannel
  alias CommentBox.{Boxes, Auth}

  setup do
    {:ok, box} = Boxes.create_box(%{url: "www.example.com"})
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(BoxChannel, "box:#{box.id}")
  
    {:ok, socket: socket, box: box}
  end


  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "send create broadcasts to room:room_id", %{socket: socket, box: box} do
    {:ok, user} = Auth.create_user(%{email: "user@example.com", password: "password", password_confirmation: "password"})
    {:ok, comment} = Boxes.create_comment(%{message: "message", box_id: box.id, user_id: user.id})
    BoxChannel.broadcast_comment_change("create", comment)
    expectation = %{inserted_at: comment.inserted_at, message: "message", user: user.id}
    assert_broadcast "create", expectation
  end
end