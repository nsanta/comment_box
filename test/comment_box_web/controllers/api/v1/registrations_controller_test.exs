defmodule CommentBoxWeb.Api.V1.RegistrationsControllerTest do
  use CommentBoxWeb.ConnCase
  alias CommentBox.Auth
  
  @valid_attrs %{email: "email@example.com", password: "some password" , password_confirmation: "some password"}
  @invalid_attrs %{}
  
  describe "POST #create" do
    test "registers a new user with valid attributes", %{conn: conn} do 
      conn = post conn, "/api/v1/registrations", user: @valid_attrs
      [user | _list] = Auth.list_users
      assert  user.email == "email@example.com"
      assert conn.status == 204
      assert Guardian.Plug.current_resource(conn).id == user.id
    end
    
    test "registers a new user with invalid attributes", %{conn: conn} do 
      conn = post conn, "/api/v1/registrations", user: @invalid_attrs
      assert Auth.list_users == []
      assert conn.status == 422
    end
  end
end