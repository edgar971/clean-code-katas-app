defmodule Katas.Challenges.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field(:user_id, :id)
    field(:solution_id, :id)

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:user_id, :solution_id])
    |> validate_required([:user_id, :solution_id])
  end
end
