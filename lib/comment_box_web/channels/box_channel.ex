defmodule CommentBoxWeb.BoxChannel do
  use Phoenix.Channel

  def join("box:" <> _private_box_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def broadcast_comment_change(event, comment) do
    payload = CommentBoxWeb.Api.V1.CommentsView.render("comment.json", %{comment: comment})
    CommentBoxWeb.Endpoint.broadcast("box:#{comment.box_id}", event, payload)
  end
end