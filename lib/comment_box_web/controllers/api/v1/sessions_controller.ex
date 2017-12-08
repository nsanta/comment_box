defmodule CommentBoxWeb.Api.V1.SessionsController do
  use CommentBoxWeb, :controller

  alias CommentBox.Auth
  alias CommentBox.Auth.Guardian

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    auth = Auth.authenticate_user(email, password)
    login_reply(auth, conn)
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> send_resp(:ok, "")
  end

  defp login_reply({:error, _error}, conn) do
    conn
    |> send_resp(:unprocessable_entity, "")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |>send_resp(:ok, "")
  end
end
