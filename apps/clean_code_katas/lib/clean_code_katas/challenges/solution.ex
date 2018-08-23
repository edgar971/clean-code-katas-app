defmodule Katas.Challenges.Solution do
  use Ecto.Schema
  import Ecto.Changeset
  alias Katas.Challenges.Challenge
  alias Katas.Accounts.User

  schema "solutions" do
    field(:code, :string)
    field(:description, :string)
    belongs_to(:user, User)
    belongs_to(:challenge, Challenge)

    timestamps()
  end

  @doc false
  def changeset(solution, attrs) do
    solution
    |> cast(attrs, [:code, :description])
    |> validate_required([:code, :description])
  end
end
