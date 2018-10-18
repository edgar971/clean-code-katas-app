defmodule Katas.Repo.Migrations.CreateChallengeComments do
  use Ecto.Migration

  def change do
    create table(:challenge_comments) do
      add(:body, :string, size: 2048)
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
      add(:challenge_id, references(:challenges, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:challenge_comments, [:user_id]))
    create(index(:challenge_comments, [:challenge_id]))
  end
end
