defmodule CommentBoxWeb.BoxesController do
  use CommentBoxWeb, :controller

  def show(conn, %{"url" => url}) do
    box = CommentBox.Boxes.get_or_create_box_by(%{url: url})
    render(conn, "show.html", box: box)
  end
end