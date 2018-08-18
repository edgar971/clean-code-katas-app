defmodule Katas.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Katas.Accounts.Credential
  alias Katas.Challenges.Solution

  schema "users" do
    field(:name, :string)
    has_one(:credential, Credential)
    # TODO: Finish implementing
    # has_many(:solutions, Solution)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
