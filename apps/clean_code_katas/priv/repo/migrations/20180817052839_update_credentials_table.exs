defmodule Katas.Repo.Migrations.UpdateCredentialsTable do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      remove :password_hash
      add :provider, :string, null: false
      add :token, :string, null: false
    end
  end
end
