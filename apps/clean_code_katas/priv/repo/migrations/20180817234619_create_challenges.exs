defmodule Katas.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add(:title, :string)
      add(:description, :string, size: 2048)
      add(:level, :string)

      timestamps()
    end
  end
end
