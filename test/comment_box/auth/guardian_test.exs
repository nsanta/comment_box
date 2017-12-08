defmodule CommentBox.Auth.GuardianTest do
  use CommentBox.DataCase
  alias CommentBox.Auth.Guardian
  alias CommentBox.Auth.User
  
  
  
  describe "subject_for_token" do
    test "return user id" do
      id = 123
      {:ok , user_id} = Guardian.subject_for_token(%User{id: id}, [])
      assert user_id == "123"
    end
  end
  
  
  describe "resource_from_claims" do
    alias CommentBox.Auth
    
    test "when user exists returns user" do
      number = Enum.random(0..100_000)
      attrs = %{email: "email#{number}@example.com", password: "somepassword"}
      {:ok , user} = Auth.create_user(attrs)
      claims = %{"sub" => user.id}
      {:ok , user_from_claims} = Guardian.resource_from_claims(claims)
      assert user.id == user_from_claims
    end
  end
end