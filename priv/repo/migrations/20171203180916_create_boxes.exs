defmodule CommentBox.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes) do
      add :url, :string

      timestamps()
    end
    create index(:boxes, [:url])
  end
end
