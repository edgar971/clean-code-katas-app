defmodule Katas.Challenges.Challenge do
  use Ecto.Schema
  import Ecto.Changeset
  alias Katas.Challenges.Solution
  alias Katas.Comments.ChallengeComments

  schema "challenges" do
    field(:description, :string)
    field(:level, :string)
    field(:title, :string)
    has_many(:solutions, Solution)
    has_many(:comments, ChallengeComments)

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:title, :description, :level])
    |> validate_required([:title, :description, :level])
  end
end
