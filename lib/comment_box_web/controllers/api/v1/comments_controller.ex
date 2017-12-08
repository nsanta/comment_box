defmodule CommentBoxWeb.Api.V1.CommentsController do
  use CommentBoxWeb, :controller
  alias CommentBox.Boxes
  alias CommentBox.Boxes.Box

  def index(conn, %{"box_id" => box_id}) do
    box = find_box(conn, box_id)
    conn |> render("index.json", comments: Boxes.list_comments(box.id))
  end

  def create(conn, %{"comment" => comment, "box_id" => box_id}) do
    box = find_box(conn, box_id)
    user_id = Guardian.Plug.current_resource(conn)
    comment_creation = Boxes.create_comment(
      Map.merge(comment, %{"box_id" => box.id, "user_id" => user_id})
    )
    conn |> comment_reply(comment_creation)
  end

  defp comment_reply(conn, {:ok, comment}) do
    CommentBoxWeb.BoxChannel.broadcast_comment_change("create", comment)
    perform_analyze_comment(comment)
    conn |> render("show.json", comment: comment)
  end

  defp comment_reply(conn, {:error, comment}) do
    conn |> render("422.json", comment: comment)
  end

  defp perform_analyze_comment(comment) do
    Task.async fn ->
      {:ok, comment_updated} = Boxes.analyze_comment(comment)
      cond do
        comment_updated.sentiment_score <= -5 -> 
          CommentBoxWeb.BoxChannel.broadcast_comment_change("delete", comment_updated) 
        true ->
      end 
    end
  end

  defp find_box(conn, box_id) do
    result = Boxes.get_box!(box_id)
    box_reply(result, conn)
  end

  defp box_reply(%Box{} = box, _conn) do
    box
  end

  defp box_reply({:error, _box}, conn) do
    conn |> send_resp(:not_found, "") |> halt()
  end
end