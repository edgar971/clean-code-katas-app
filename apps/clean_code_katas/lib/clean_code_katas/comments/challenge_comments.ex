defmodule Katas.Comments.ChallengeComments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenge_comments" do
    field(:body, :string, size: 2048)
    field(:user_id, :id)
    field(:challenge_id, :id)

    timestamps()
  end

  @doc false
  def changeset(challenge_comments, attrs) do
    challenge_comments
    |> cast(attrs, [:body, :user_id, :challenge_id])
    |> validate_required([:body, :user_id, :challenge_id])
  end
end
