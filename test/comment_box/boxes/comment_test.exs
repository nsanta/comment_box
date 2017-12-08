defmodule CommentBox.Auth.CommentTest do
  use CommentBox.DataCase
  alias CommentBox.Boxes
  alias CommentBox.Boxes.Comment
  alias CommentBox.Auth

  @user_attrs %{email: "email@example.com", password: "password", password_confirmation: "password"}
  @box_attrs %{url: "www.example.com" }
  @valid_attrs %{message: "www.awesomecommentbox.com"}
  @invalid_attrs %{}


  describe "changeset" do
    test "changeset with valid attributes" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      changeset = Comment.changeset(
        %Comment{}, 
        Map.merge(%{user_id: user.id, box_id: box.id}, @valid_attrs)
      )
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Comment.changeset(%Comment{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end