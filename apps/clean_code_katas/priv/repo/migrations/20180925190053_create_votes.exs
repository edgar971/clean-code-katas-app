defmodule CleanCodeKatas.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add(:user_id, references(:users, on_delete: :delete_all, null: false))
      add(:solution_id, references(:solutions, on_delete: :delete_all, null: false))

      timestamps()
    end

    create(index(:votes, [:user_id]))
    create(index(:votes, [:solution_id]))
  end
end
