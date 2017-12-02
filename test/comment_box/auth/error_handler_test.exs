defmodule CommentBox.Auth.ErrorHandlerTest do
  use CommentBoxWeb.ConnCase
  
  alias CommentBox.Auth.ErrorHandler
  alias Phoenix.ConnTest
  
  describe "auth_error" do
    test "respond with error" do
      result = ErrorHandler.auth_error(ConnTest.build_conn(), {'type', 'reason'}, [])
      assert result.status == 401
    end
  end
end