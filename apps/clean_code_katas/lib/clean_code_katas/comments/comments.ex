defmodule Katas.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias Katas.Repo

  alias Katas.Comments.ChallengeComments

  @doc """
  Returns the list of challenge_comments.

  ## Examples

      iex> list_challenge_comments(challenge_id)
      [%ChallengeComments{}, ...]

  """
  def list_challenge_comments(challenge_id) do
    from(
      c in ChallengeComments,
      where: c.challenge_id == ^challenge_id,
      preload: [:user]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single challenge_comments.

  Raises `Ecto.NoResultsError` if the Challenge comments does not exist.

  ## Examples

      iex> get_challenge_comments!(123)
      %ChallengeComments{}

      iex> get_challenge_comments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_challenge_comments!(id) do
    from(
      c in ChallengeComments,
      where: c.id == ^id,
      preload: [:user]
    )
    |> Repo.one!()
  end

  @doc """
  Creates a challenge_comments.

  ## Examples

      iex> create_challenge_comments(%{field: value})
      {:ok, %ChallengeComments{}}

      iex> create_challenge_comments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_challenge_comments(challenge, user, attrs \\ %{}) do
    challenge
    |> Ecto.build_assoc(:comments)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:user, user)
    |> ChallengeComments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a challenge_comments.

  ## Examples

      iex> update_challenge_comments(challenge_comments, %{field: new_value})
      {:ok, %ChallengeComments{}}

      iex> update_challenge_comments(challenge_comments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_challenge_comments(%ChallengeComments{} = challenge_comments, attrs) do
    challenge_comments
    |> ChallengeComments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ChallengeComments.

  ## Examples

      iex> delete_challenge_comments(challenge_comments)
      {:ok, %ChallengeComments{}}

      iex> delete_challenge_comments(challenge_comments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_challenge_comments(%ChallengeComments{} = challenge_comments) do
    Repo.delete(challenge_comments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking challenge_comments changes.

  ## Examples

      iex> change_challenge_comments(challenge_comments)
      %Ecto.Changeset{source: %ChallengeComments{}}

  """
  def change_challenge_comments(%ChallengeComments{} = challenge_comments) do
    ChallengeComments.changeset(challenge_comments, %{})
  end
end
