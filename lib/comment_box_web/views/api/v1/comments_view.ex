defmodule CommentBoxWeb.Api.V1.CommentsView do
  use CommentBoxWeb, :view
  alias CommentBoxWeb.Api.V1.CommentsView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentsView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentsView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
    message: comment.message,
    user_id:  comment.user_id,
    inserted_at: comment.inserted_at,
    sentiment_score: comment.sentiment_score}
  end

  def render("comment.json", %{comments: comments}) do
    render("comment.json", %{comment: comments})
  end
end