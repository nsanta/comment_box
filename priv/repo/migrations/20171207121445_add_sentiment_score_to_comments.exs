defmodule CommentBox.Repo.Migrations.AddSentimentScoreToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :sentiment_score, :integer
    end
  end
end
