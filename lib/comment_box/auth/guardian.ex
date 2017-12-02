defmodule CommentBox.Auth.Guardian do
  @moduledoc """
  The Guardian module.
  """

  use Guardian, otp_app: :comment_box
  
  alias CommentBox.Auth

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    user_to_claim = claims["sub"]
    case Auth.get_user!(user_to_claim) do
      nil ->
        {:error, nil}
      _user ->
        {:ok, user_to_claim}
    end
  end


end
