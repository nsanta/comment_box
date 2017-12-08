defmodule CommentBox.Repo.Migrations.CommentBelongsToBox do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :box_id, references(:boxes)
    end

    create index(:comments, [:box_id])
  end
end
