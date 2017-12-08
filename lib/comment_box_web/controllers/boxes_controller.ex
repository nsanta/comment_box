defmodule CommentBoxWeb.BoxesController do
  use CommentBoxWeb, :controller

  def show(conn, %{"url" => url}) do
    {:ok, box} = CommentBox.Boxes.get_or_create_box_by(%{url: url})
    logged_in = authenticated?(conn)
    render(conn, "show.html", %{box_id: box.id, logged_in: logged_in})
  end

  def show(conn, %{}) do
    render(conn, CommentBoxWeb.ErrorView, "404.html")
  end

  defp authenticated?(conn) do
    Guardian.Plug.current_resource(conn) === "1"
  end
end