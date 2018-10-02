defmodule Katas.Repo.Migrations.UpdateVotesMakeUserSolutionUnique do
  use Ecto.Migration

  def change do
    create(unique_index(:votes, [:user_id, :solution_id], name: :votes_user_id_solution_id_index))
  end
end
