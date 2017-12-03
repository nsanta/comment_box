defmodule CommentBox.Auth.Pipeline do
  @moduledoc """
  The Pipeline for authentication.
  """

  use Guardian.Plug.Pipeline,
    otp_app: :comment_box,
    error_handler: CommentBox.Auth.ErrorHandler,
    module: CommentBox.Auth.Guardian
  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession, claims: %{"type" => "access"}
  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"type" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end
