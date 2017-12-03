defmodule CommentBox.Auth.BoxTest do
  use CommentBox.DataCase
  alias CommentBox.Boxes.Box

  @valid_attrs %{url: "www.awesomecommentbox.com"}
  @invalid_attrs %{}


  describe "changeset" do
    test "changeset with valid attributes" do
      changeset = Box.changeset(%Box{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Box.changeset(%Box{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end