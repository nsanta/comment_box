defmodule CommentBox.Boxes do
  @moduledoc """
  The Boxes context.
  """

  import Ecto.Query, warn: false
  alias CommentBox.Repo

  alias CommentBox.Boxes.Box

  @doc """
  Returns the list of boxes.

  ## Examples

      iex> list_boxes()
      [%Box{}, ...]

  """
  def list_boxes do
    Repo.all(Box)
  end

  @doc """
  Gets a single box.

  Raises `Ecto.NoResultsError` if the Box does not exist.

  ## Examples

      iex> get_box!(123)
      %Box{}

      iex> get_box!(456)
      ** (Ecto.NoResultsError)

  """
  def get_box!(id), do: Repo.get!(Box, id)

  def get_or_create_box_by(query) do 
    case Repo.get_by(Box, query) do
    nil ->  create_box(query)
    %Box{} = box -> {:ok, box}
    end
  end

  @doc """
  Creates a box.

  ## Examples

      iex> create_box(%{field: value})
      {:ok, %Box{}}

      iex> create_box(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_box(attrs \\ %{}) do
    %Box{}
    |> Box.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a box.

  ## Examples

      iex> update_box(box, %{field: new_value})
      {:ok, %Box{}}

      iex> update_box(box, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_box(%Box{} = box, attrs) do
    box
    |> Box.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Box.

  ## Examples

      iex> delete_box(box)
      {:ok, %Box{}}

      iex> delete_box(box)
      {:error, %Ecto.Changeset{}}

  """
  def delete_box(%Box{} = box) do
    Repo.delete(box)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking box changes.

  ## Examples

      iex> change_box(box)
      %Ecto.Changeset{source: %Box{}}

  """
  def change_box(%Box{} = box) do
    Box.changeset(box, %{})
  end

  alias CommentBox.Boxes.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments(box_id) do
    query = from c in Comment, 
      where: c.box_id == ^box_id and c.sentiment_score > -5,
      order_by: c.inserted_at
    Repo.all(query)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end


  def analyze_comment(%Comment{} = comment) do 
    score = Sentient.analyze(comment.message)
    IO.inspect "MESSAGE ANALYZED: #{comment.message} AND SCORE: #{score}"
    update_comment(comment, %{sentiment_score: score})
  end
end
