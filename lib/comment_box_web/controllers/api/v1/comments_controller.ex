defmodule CommentBoxWeb.Api.V1.CommentsController do
  use CommentBoxWeb, :controller
  alias CommentBox.Boxes
  alias CommentBox.Boxes.{Box, Comment}

  def index(conn, %{"box_id" => box_id}) do
    box = find_box(conn, box_id)
    conn |> render('index.json', comments: Boxes.list_comments(box.id))
  end

  def create(conn, %{"comment" => comment, "box_id" => box_id}) do
    box = find_box(conn, box_id)
    {:ok, user} = Guardian.Plug.current_resource(conn)
    comment_creation = Boxes.create_comment(
      Map.merge(comment, %{box_id: box.id, user_id: user.id})
    )
    conn |> comment_reply(comment_creation)
  end

  defp comment_reply(conn, {:ok, comment}) do
    conn |> render('show.json', comment: comment)
  end

  defp comment_reply(conn, {:error, comment}) do
    conn |> render('422.json', comment: comment)
  end

  defp find_box(conn, box_id) do
    CommentBox.Boxes.get_box!(box_id)
    |> box_reply(conn)
  end

  defp box_reply({:ok, box}, conn) do
    box
  end

  defp box_reply({:error, box}, conn) do
    conn |> send_resp(:not_found, "") |> halt()
  end
end