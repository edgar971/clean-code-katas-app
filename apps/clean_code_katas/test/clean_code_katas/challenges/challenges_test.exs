defmodule Katas.ChallengesTest do
  use Katas.DataCase

  alias Katas.Challenges

  describe "challenges" do
    alias Katas.Challenges.Challenge

    @valid_attrs %{description: "some description", level: "some level", title: "some title"}
    @update_attrs %{description: "some updated description", level: "some updated level", title: "some updated title"}
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
      assert Challenges.list_challenges() == [challenge]
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
      {:ok, solution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Challenges.create_solution()

      solution
    end

    test "list_solutions/0 returns all solutions" do
      solution = solution_fixture()
      assert Challenges.list_solutions() == [solution]
    end

    test "get_solution!/1 returns the solution with given id" do
      solution = solution_fixture()
      assert Challenges.get_solution!(solution.id) == solution
    end

    test "create_solution/1 with valid data creates a solution" do
      assert {:ok, %Solution{} = solution} = Challenges.create_solution(@valid_attrs)
      assert solution.code == "some code"
      assert solution.description == "some description"
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
end
