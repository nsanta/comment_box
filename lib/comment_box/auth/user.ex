defmodule CommentBox.Auth.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias CommentBox.Auth.User
  alias Comeonin.Bcrypt

  @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/


  schema "users" do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_format(:email, @mail_regex)
    |> validate_required([:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
