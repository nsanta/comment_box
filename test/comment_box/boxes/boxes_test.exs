defmodule CommentBox.BoxesTest do
  use CommentBox.DataCase

  alias CommentBox.Boxes

  describe "boxes" do
    alias CommentBox.Boxes.Box

    @valid_attrs %{url: "some url"}
    @update_attrs %{url: "some updated url"}
    @invalid_attrs %{url: nil}

    def box_fixture(attrs \\ %{}) do
      {:ok, box} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boxes.create_box()

      box
    end

    test "list_boxes/0 returns all boxes" do
      box = box_fixture()
      assert Boxes.list_boxes() == [box]
    end

    test "get_box!/1 returns the box with given id" do
      box = box_fixture()
      assert Boxes.get_box!(box.id) == box
    end

    test "create_box/1 with valid data creates a box" do
      assert {:ok, %Box{} = box} = Boxes.create_box(@valid_attrs)
      assert box.url == "some url"
    end

    test "create_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boxes.create_box(@invalid_attrs)
    end

    test "update_box/2 with valid data updates the box" do
      box = box_fixture()
      assert {:ok, box} = Boxes.update_box(box, @update_attrs)
      assert %Box{} = box
      assert box.url == "some updated url"
    end

    test "update_box/2 with invalid data returns error changeset" do
      box = box_fixture()
      assert {:error, %Ecto.Changeset{}} = Boxes.update_box(box, @invalid_attrs)
      assert box == Boxes.get_box!(box.id)
    end

    test "delete_box/1 deletes the box" do
      box = box_fixture()
      assert {:ok, %Box{}} = Boxes.delete_box(box)
      assert_raise Ecto.NoResultsError, fn -> Boxes.get_box!(box.id) end
    end

    test "change_box/1 returns a box changeset" do
      box = box_fixture()
      assert %Ecto.Changeset{} = Boxes.change_box(box)
    end
  end

  describe "comments" do
    alias CommentBox.Boxes.Comment
    alias CommentBox.Boxes
    alias CommentBox.Auth

    @user_attrs %{email: "email@example.com", password: "password", password_confirmation: "password"}
    @box_attrs %{url: "www.example.com" }
    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boxes.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert Boxes.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert Boxes.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      
      assert {:ok, %Comment{} = comment} = Boxes.create_comment(
        Map.merge(%{user_id: user.id, box_id: box.id}, @valid_attrs)
      )
      assert comment.message == "some message"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boxes.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert {:ok, comment} = Boxes.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.message == "some updated message"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert {:error, %Ecto.Changeset{}} = Boxes.update_comment(comment, @invalid_attrs)
      assert comment == Boxes.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert {:ok, %Comment{}} = Boxes.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Boxes.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      {:ok, user} = Auth.create_user(@user_attrs)
      {:ok, box} = Boxes.create_box(@box_attrs)
      comment = comment_fixture(%{user_id: user.id, box_id: box.id})
      assert %Ecto.Changeset{} = Boxes.change_comment(comment)
    end
  end
end
