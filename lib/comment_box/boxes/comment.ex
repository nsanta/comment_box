defmodule CommentBox.Boxes.Comment do
  @moduledoc """
  The Comment model.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias CommentBox.Boxes.{Comment, Box}
  alias CommentBox.Auth.User

  schema "comments" do
    field :message, :string
    belongs_to :box, Box
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:message, :user_id, :box_id])
    |> validate_required([:message, :user_id, :box_id])
  end
end
