defmodule CommentBoxWeb.Api.V1.JsonErrorView do
  use CommentBoxWeb, :view

  def render("422.json", changeset) do
    %{error: changeset.errors}
  end

  def render("500.json", _assigns) do
    %{error: "Internal server error"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, _assigns) do
    %{error: "Internal server error"}
  end
end
