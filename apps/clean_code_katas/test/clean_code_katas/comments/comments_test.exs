defmodule Katas.CommentsTest do
  import Katas.Factory

  use Katas.DataCase
  alias Katas.Comments

  describe "challenge_comments" do
    alias Katas.Comments.ChallengeComments

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def challenge_comments_fixture() do
      challenge = insert(:challenge)
      user = insert(:user)

      {:ok, challenge_comments} =
        Comments.create_challenge_comments(challenge, user, @valid_attrs)

      challenge_comments
    end

    test "create_challenge_comments/1 with valid data creates a challenge_comments" do
      challenge = insert(:challenge)
      user = insert(:user)

      assert {:ok, %ChallengeComments{} = challenge_comments} =
               Comments.create_challenge_comments(challenge, user, @valid_attrs)

      assert challenge_comments.body == "some body"
    end

    test "create_challenge_comments/1 with invalid data returns error changeset" do
      challenge = insert(:challenge)
      user = insert(:user)

      assert {:error, %Ecto.Changeset{}} =
               Comments.create_challenge_comments(challenge, user, @invalid_attrs)
    end

    test "list_challenge_comments/1 returns all comments for a challenge" do
      challenge_comments = challenge_comments_fixture()

      assert Comments.list_challenge_comments(challenge_comments.challenge_id) == [
               challenge_comments
             ]
    end

    test "get_challenge_comments!/1 returns the challenge_comments with given id" do
      challenge_comments = challenge_comments_fixture()
      assert Comments.get_challenge_comments!(challenge_comments.id) == challenge_comments
    end

    test "update_challenge_comments/2 with valid data updates the challenge_comments" do
      challenge_comments = challenge_comments_fixture()

      assert {:ok, challenge_comments} =
               Comments.update_challenge_comments(challenge_comments, @update_attrs)

      assert %ChallengeComments{} = challenge_comments
      assert challenge_comments.body == "some updated body"
    end

    test "update_challenge_comments/2 with invalid data returns error changeset" do
      challenge_comments = challenge_comments_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Comments.update_challenge_comments(challenge_comments, @invalid_attrs)

      assert challenge_comments == Comments.get_challenge_comments!(challenge_comments.id)
    end

    test "delete_challenge_comments/1 deletes the challenge_comments" do
      challenge_comments = challenge_comments_fixture()
      assert {:ok, %ChallengeComments{}} = Comments.delete_challenge_comments(challenge_comments)

      assert_raise Ecto.NoResultsError, fn ->
        Comments.get_challenge_comments!(challenge_comments.id)
      end
    end

    test "change_challenge_comments/1 returns a challenge_comments changeset" do
      challenge_comments = challenge_comments_fixture()
      assert %Ecto.Changeset{} = Comments.change_challenge_comments(challenge_comments)
    end
  end
end
