defmodule CommentBoxWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias CommentBox.Auth

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import CommentBoxWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint CommentBoxWeb.Endpoint
    end
  end

  @default_opts [
    store: :cookie,
    key: "secretkey",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(CommentBox.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CommentBox.Repo, {:shared, self()})
    end
    {conn, user} = if tags[:authenticated] do
      {:ok, user} = Auth.create_user(
        %{email: "firstuser@example.com", password: "password", password_confirmation: "password"}
      )
      conn = Phoenix.ConnTest.build_conn()
      |> Plug.Session.call(@signing_opts)
      |> Plug.Conn.fetch_session()
      |> Guardian.Plug.sign_in(user, :access)
      |> Guardian.Plug.VerifySession.call(%{})
      {conn, user}
    else
      {Phoenix.ConnTest.build_conn(), nil}
    end

    {:ok, conn: conn, user: user}
  end

end
