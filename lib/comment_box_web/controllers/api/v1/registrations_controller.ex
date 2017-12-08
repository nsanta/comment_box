defmodule CommentBoxWeb.Api.V1.RegistrationsController do
  use CommentBoxWeb, :controller

  alias CommentBox.Auth
  alias CommentBox.Auth.Guardian

  def create(conn, %{"user" => user_params}) do
    result = Auth.create_user(user_params)
    registrations_reply(result, conn)
  end


  defp registrations_reply({:error, error}, conn) do
    conn
    |> send_resp(:unprocessable_entity, "")
  end

  defp registrations_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> send_resp(:ok, "")
  end
end
