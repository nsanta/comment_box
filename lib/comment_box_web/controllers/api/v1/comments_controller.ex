defmodule CommentBoxWeb.Api.V1.CommentsController do
  use CommentBoxWeb, :controller
  alias CommentBox.Boxes

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
    CommentBoxWeb.BoxChannel.broadcast_comment_change('create', comment)
    perform_analyze_comment(comment)
    conn |> render('show.json', comment: comment)
  end

  defp comment_reply(conn, {:error, comment}) do
    conn |> render('422.json', comment: comment)
  end

  defp perform_analyze_comment(comment) do
    Task.async fn ->
      {:ok, result} = Boxes.analyze_comment(comment)
      cond do
        result < -5 -> 
          CommentBoxWeb.BoxChannel.broadcast_comment_change('delete', comment) 
      end 
    end
  end

  defp find_box(conn, box_id) do
    {:ok, box} = CommentBox.Boxes.get_box!(box_id)
    box_reply(box, conn)
  end

  defp box_reply({:ok, box}, _conn) do
    box
  end

  defp box_reply({:error, _box}, conn) do
    conn |> send_resp(:not_found, "") |> halt()
  end
end