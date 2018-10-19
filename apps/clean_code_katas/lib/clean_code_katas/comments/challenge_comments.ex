defmodule Katas.Comments.ChallengeComments do
  use Ecto.Schema
  import Ecto.Changeset

  alias Katas.Accounts.User
  alias Katas.Challenges.Challenge

  schema "challenge_comments" do
    field(:body, :string, size: 2048)
    belongs_to(:challenge, Challenge)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(challenge_comments, attrs) do
    challenge_comments
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
