defmodule CommentBoxWeb.Api.V1.SessionsControllerTest do
  use CommentBoxWeb.ConnCase
  alias CommentBox.Auth
  
  @valid_attrs %{email: "email@example.com", password: "some password"}
  @invalid_attrs %{email: "email@example.com", password: "wrong password"}
  
  describe "POST #create" do
    test "user logs in with valid attributes", %{conn: conn} do 
      {:ok, user} = Auth.create_user(Map.merge(@valid_attrs, %{password_confirmation: "some password"}))
      conn = post conn, "/api/v1/sessions", user: @valid_attrs
      assert conn.status == 204
      assert Guardian.Plug.current_resource(conn) == Auth.get_user!(user.id)
    end
    
    test "registers a new user with invalid attributes", %{conn: conn} do 
      {:ok, user} = Auth.create_user(Map.merge(@valid_attrs, %{password_confirmation: "some password"}))
      conn = post conn, "/api/v1/sessions", user: @invalid_attrs
      assert conn.status == 422
    end
  end

  describe "DELETE #delete" do
    test "user logs in with valid attributes", %{conn: conn} do 
      {:ok, user} = Auth.create_user(Map.merge(@valid_attrs, %{password_confirmation: "some password"}))
      conn = post conn, "/api/v1/sessions", user: @valid_attrs
      conn = delete conn, "/api/v1/sessions"
      assert conn.status == 204
      refute Guardian.Plug.current_resource(conn)
    end
  end
end