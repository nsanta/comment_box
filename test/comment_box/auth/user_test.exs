defmodule CommentBox.Auth.UserTest do
  use CommentBox.DataCase
  alias CommentBox.Auth.User

  @valid_attrs %{email: "email@example.com", password: "some password" , password_confirmation: "some password"}
  @invalid_attrs %{}
  @invalid_email_attrs %{email: "invalid email address"}
  @invalid_password_attrs %{email: "email@example.com", password: "some password" , password_confirmation: "not the same password"}

  describe "changeset" do
    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
    
    test "changeset with invalid email address" do
      changeset = User.changeset(%User{}, @invalid_email_attrs)
      refute changeset.valid?
    end
    
    test "changeset with invalid password match" do
      changeset = User.changeset(%User{}, @invalid_password_attrs)
      refute changeset.valid?
    end
  end
end
