defmodule CommentBox.Boxes.Box do
  @moduledoc """
  The Box model.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias CommentBox.Boxes.{Box, Comment}

  schema "boxes" do
    field :url, :string
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(%Box{} = box, attrs) do
    box
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
