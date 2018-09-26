defmodule Katas.ChallengesTest do
  import Katas.Factory

  use Katas.DataCase
  alias Katas.Challenges

  describe "challenges" do
    alias Katas.Challenges.Challenge

    @valid_attrs %{description: "some description", level: "some level", title: "some title"}
    @update_attrs %{
      description: "some updated description",
      level: "some updated level",
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, level: nil, title: nil}

    def challenge_fixture(attrs \\ %{}) do
      {:ok, challenge} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Challenges.create_challenge()

      challenge
    end

    test "list_challenges/0 returns all challenges" do
      challenge = challenge_fixture()
      challenges = Challenges.list_challenges()
      assert challenges == [challenge]
    end

    test "list_challenges/0 returns all challenges with number of solution" do
      user = insert(:user)
      challenge = challenge_fixture()

      %{
        code: "just code",
        description: "some description",
        user_id: user.id,
        challenge_id: challenge.id
      }
      |> Challenges.create_solution()

      challenges = Challenges.list_challenges_with_solution_count()
      assert challenges == [{challenge, 1}]
    end

    test "get_challenge!/1 returns the challenge with given id" do
      challenge = challenge_fixture()
      assert Challenges.get_challenge!(challenge.id) == challenge
    end

    test "create_challenge/1 with valid data creates a challenge" do
      assert {:ok, %Challenge{} = challenge} = Challenges.create_challenge(@valid_attrs)
      assert challenge.description == "some description"
      assert challenge.level == "some level"
      assert challenge.title == "some title"
    end

    test "create_challenge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Challenges.create_challenge(@invalid_attrs)
    end

    test "update_challenge/2 with valid data updates the challenge" do
      challenge = challenge_fixture()
      assert {:ok, challenge} = Challenges.update_challenge(challenge, @update_attrs)
      assert %Challenge{} = challenge
      assert challenge.description == "some updated description"
      assert challenge.level == "some updated level"
      assert challenge.title == "some updated title"
    end

    test "update_challenge/2 with invalid data returns error changeset" do
      challenge = challenge_fixture()
      assert {:error, %Ecto.Changeset{}} = Challenges.update_challenge(challenge, @invalid_attrs)
      assert challenge == Challenges.get_challenge!(challenge.id)
    end

    test "delete_challenge/1 deletes the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{}} = Challenges.delete_challenge(challenge)
      assert_raise Ecto.NoResultsError, fn -> Challenges.get_challenge!(challenge.id) end
    end

    test "change_challenge/1 returns a challenge changeset" do
      challenge = challenge_fixture()
      assert %Ecto.Changeset{} = Challenges.change_challenge(challenge)
    end
  end

  describe "solutions" do
    alias Katas.Challenges.Solution

    @valid_attrs %{code: "some code", description: "some description"}
    @update_attrs %{code: "some updated code", description: "some updated description"}
    @invalid_attrs %{code: nil, description: nil}

    def solution_fixture(attrs \\ %{}) do
      %{id: user_id} = insert(:user)
      %{id: challenge_id} = insert(:challenge)

      user_and_challenge = %{user_id: user_id, challenge_id: challenge_id}

      {:ok, solution} =
        user_and_challenge
        |> Enum.into(attrs)
        |> Enum.into(@valid_attrs)
        |> Challenges.create_solution()

      solution
      |> Repo.preload(:challenge)
      |> Repo.preload(:user)
    end

    test "get_solution!/1 returns the solution with given id" do
      solution = solution_fixture()
      assert Challenges.get_solution!(solution.id) == solution
    end

    test "create_solution/1 with valid data creates a solution" do
      user = insert(:user)
      challenge = insert(:challenge)

      solution_changeset = %{
        code: @valid_attrs.code,
        description: @valid_attrs.description,
        user_id: user.id,
        challenge_id: challenge.id
      }

      assert {:ok, %Solution{} = solution} = Challenges.create_solution(solution_changeset)
      assert solution.code == "some code"
      assert solution.description == "some description"

      solution_record = Challenges.get_solution!(solution.id)
      assert solution_record.user.id == user.id
      assert solution_record.challenge.id == challenge.id
    end

    test "create_solution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Challenges.create_solution(@invalid_attrs)
    end

    test "update_solution/2 with valid data updates the solution" do
      solution = solution_fixture()
      assert {:ok, solution} = Challenges.update_solution(solution, @update_attrs)
      assert %Solution{} = solution
      assert solution.code == "some updated code"
      assert solution.description == "some updated description"
    end

    test "update_solution/2 with invalid data returns error changeset" do
      solution = solution_fixture()
      assert {:error, %Ecto.Changeset{}} = Challenges.update_solution(solution, @invalid_attrs)
      assert solution == Challenges.get_solution!(solution.id)
    end

    test "delete_solution/1 deletes the solution" do
      solution = solution_fixture()
      assert {:ok, %Solution{}} = Challenges.delete_solution(solution)
      assert_raise Ecto.NoResultsError, fn -> Challenges.get_solution!(solution.id) end
    end

    test "change_solution/1 returns a solution changeset" do
      solution = solution_fixture()
      assert %Ecto.Changeset{} = Challenges.change_solution(solution)
    end
  end

  describe "votes" do
    alias Katas.Challenges.Vote

    test "upvote_solution/2 creates a vote record" do
      %{id: user_id} = insert(:user)
      %{id: solution_id} = insert(:solution)

      assert {:ok, %Vote{} = record} = Challenges.upvote_solution(user_id, solution_id)
      assert record.user_id == user_id
      assert record.solution_id == solution_id
    end

    test "solution_votes/1 returns the number of votes" do
      %{id: user_one_id} = insert(:user)
      %{id: user_two_id} = insert(:user)
      %{id: solution_id} = insert(:solution)

      Challenges.upvote_solution(user_one_id, solution_id)
      Challenges.upvote_solution(user_two_id, solution_id)

      assert Challenges.get_solution_votes(solution_id) == 2
    end
  end
end
