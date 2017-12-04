defmodule CommentBoxWeb.Api.V1.CommentsControllerTest do
  use CommentBoxWeb.ConnCase
  alias CommentBox.{Auth, Boxes}

  
  describe "GET /index" do
    @tag :authenticated

    test "returns 404 is box not found", %{conn: conn, user: user} do
      Boxes.create_box(%{url: "www.example.com"})
      conn = get conn, '/api/v1/comments', box_id: -1
      assert conn.status == 404
    end

    test "returns all the comments associated to a box", %{conn: conn, user: user} do
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

  describe "POST /create" do
    @tag :authenticated
    @valid_attrs %{message: "Message"}
    @invalid_attrs %{message: ""}

    test "returns 404 is box not found", %{conn: conn, user: user} do
      Boxes.create_box(%{url: "www.example.com"})
      conn = post conn, '/api/v1/comments', box_id: -1, comment: @valid_attrs
      assert conn.status == 404
    end

    test "creates a new comment with valid attributes", %{conn: conn, user: user} do
      {:ok, box} = Boxes.create_box(%{url: "www.example.com"})
      {:ok, user} = Auth.create_user(
        %{email: "user1@email.com", password: "password", password_confirmation: "password"}
      )
      {:ok, comment} = Boxes.create_comment(
        %{message: "message", user_id: user.id, box_id: box.id}
      )
      conn = post conn, '/api/v1/comments', box_id: box.id, comment: @valid_attrs
      assert conn.status == 200
      assert json_response(conn, 200) == %{"data" => comment}
    end

    test "returns an error when provides invalid attributes", %{conn: conn, user: user} do
      {:ok, box} = Boxes.create_box(%{url: "www.example.com"})
      {:ok, user} = Auth.create_user(
        %{email: "user1@email.com", password: "password", password_confirmation: "password"}
      )
      {:ok, comment} = Boxes.create_comment(
        %{message: "message", user_id: user.id, box_id: box.id}
      )
      conn = post conn, '/api/v1/comments', box_id: box.id, comment: @invalid_attrs
      assert conn.status == 422
      assert json_response(conn, 422) == %{"data" => comment}
    end

  end
end