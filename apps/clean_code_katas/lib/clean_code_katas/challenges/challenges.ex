defmodule Katas.Challenges do
  @moduledoc """
  The Challenges context.
  """

  import Ecto.Query, warn: false
  alias Katas.Repo

  alias Katas.Challenges.Challenge
  alias Katas.Challenges.Solution
  alias Katas.Comments.ChallengeComments

  @doc """
  Returns the list of challenges.

  ## Examples

      iex> list_challenges()
      [%Challenge{}, ...]

  """
  def list_challenges do
    from(Challenge) |> Repo.all()
  end

  @doc """
  Returns the list of challenges with solutions count.

  ## Examples

      iex> list_challenges_with_solution_count()
      [%Challenge{}, ...]

  """
  def list_challenges_with_solution_count do
    from(
      c in Challenge,
      left_join: s in Solution,
      on: s.challenge_id == c.id,
      group_by: c.id,
      select: {c, count(s.id)}
    )
    |> Repo.all()
  end

  @doc """
  Gets a single challenge.

  Raises `Ecto.NoResultsError` if the Challenge does not exist.

  ## Examples

      iex> get_challenge!(123)
      %Challenge{}

      iex> get_challenge!(456)
      ** (Ecto.NoResultsError)

  """
  def get_challenge!(id) do
    comments_query =
      from(comment in ChallengeComments, order_by: [asc: comment.inserted_at], preload: :user)

    from(
      c in Challenge,
      where: c.id == ^id,
      preload: [solutions: [:user], comments: ^comments_query]
    )
    |> Repo.one!()
  end

  @doc """
  Creates a challenge.

  ## Examples

      iex> create_challenge(%{field: value})
      {:ok, %Challenge{}}

      iex> create_challenge(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_challenge(attrs \\ %{}) do
    %Challenge{}
    |> Challenge.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a challenge.

  ## Examples

      iex> update_challenge(challenge, %{field: new_value})
      {:ok, %Challenge{}}

      iex> update_challenge(challenge, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_challenge(%Challenge{} = challenge, attrs) do
    challenge
    |> Challenge.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Challenge.

  ## Examples

      iex> delete_challenge(challenge)
      {:ok, %Challenge{}}

      iex> delete_challenge(challenge)
      {:error, %Ecto.Changeset{}}

  """
  def delete_challenge(%Challenge{} = challenge) do
    Repo.delete(challenge)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking challenge changes.

  ## Examples

      iex> change_challenge(challenge)
      %Ecto.Changeset{source: %Challenge{}}

  """
  def change_challenge(%Challenge{} = challenge) do
    Challenge.changeset(challenge, %{})
  end

  @doc """
  Gets a single solution.

  Raises `Ecto.NoResultsError` if the Solution does not exist.

  ## Examples

      iex> get_solution!(123)
      %Solution{}

      iex> get_solution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_solution!(id) do
    Repo.one!(from(s in Solution, where: s.id == ^id, preload: [:user, :challenge]))
  end

  @doc """
  Creates a solution.

  ## Examples

      iex> create_solution(%{field: value})
      {:ok, %Solution{}}

      iex> create_solution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_solution(attrs \\ %{}) do
    %Solution{}
    |> Solution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a solution.

  ## Examples

      iex> update_solution(solution, %{field: new_value})
      {:ok, %Solution{}}

      iex> update_solution(solution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_solution(%Solution{} = solution, attrs) do
    solution
    |> Solution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Solution.

  ## Examples

      iex> delete_solution(solution)
      {:ok, %Solution{}}

      iex> delete_solution(solution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_solution(%Solution{} = solution) do
    Repo.delete(solution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking solution changes.

  ## Examples

      iex> change_solution(solution)
      %Ecto.Changeset{source: %Solution{}}

  """
  def change_solution(%Solution{} = solution) do
    Solution.changeset(solution, %{})
  end

  alias Katas.Challenges.Vote

  def upvote_solution(user_id, solution_id) do
    attrs = %{user_id: user_id, solution_id: solution_id}

    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
  end

  def get_solution_votes(solution_id) do
    from(
      vote in Vote,
      select: count(vote.id),
      where: vote.solution_id == ^solution_id
    )
    |> Repo.one()
  end
end
