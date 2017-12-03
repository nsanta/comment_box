defmodule CommentBoxWeb.Api.V1.CommentsControllerTest do
  use CommentBoxWeb.ConnCase
  alias CommentBox.{Auth, Boxes}

  
  describe "GET /index" do
    @tag :authenticated

    test "returns 404 is box not found", %{conn: conn} do
      Boxes.create_box(%{url: "www.example.com"})
      conn = get conn, '/api/v1/comments', box_id: -1
      assert conn.status == 404
    end

    test "returns all the comments associated to a box", %{conn: conn} do
      {:ok, box} = Boxes.create_box(%{url: "www.example.com"})
      {:ok, user} = Auth.create_user(
        %{email: "user1@email.com", password: "password", password_confirmation: "password"}
      )
      {:ok, comment} = Boxes.create_comment(
        %{message: "message", user_id: user.id, box_id: box.id}
      )

      conn = get conn, '/api/v1/comments', box_id: box.id
      assert conn.status == 200
      assert json_response(conn, 200) == %{"data" => comment}
    end

  end
end