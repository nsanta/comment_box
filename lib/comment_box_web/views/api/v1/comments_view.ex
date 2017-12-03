defmodule CommentBoxWeb.Api.V1.CommentsView do
  use CommentBoxWeb, :view
  alias CommentBoxWeb.Api.V1.CommentsView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentsView, "comment.json")}
  end

  def render("show.json", %{comments: comments}) do
    %{data: render_one(comments, CommentsView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{message: comment.message,
      user:  comment.user_id,
      created_at: comment.created_at}
  end
end