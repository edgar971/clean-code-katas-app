defmodule KatasWeb.CommentsControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  @valid_comment %{comment: "This is awesome"}

  defp authenticate_user(conn) do
    user = insert(:user)

    conn
    |> assign(:user, user)
  end

  describe "comments when users is not logged in" do
    test "redirects the user and adds error message", %{conn: conn} do
      conn = post(conn, comments_path(conn, :create, "challenge", 1, @valid_comment))
      assert redirected_to(conn, 302)
      assert get_flash(conn, :error) == "You must be logged in."
    end
  end

  describe "comments when user is logged in" do
    test "creating a comment for a challenge", %{conn: conn} do
      challenge = insert(:challenge)

      conn =
        conn
        |> authenticate_user()
        |> post(comments_path(conn, :create, "challenge", challenge.id, @valid_comment))

      assert redirected_to(conn, 302)

      [comment_record] = Katas.Comments.list_challenge_comments(challenge.id)
      assert comment_record.body == @valid_comment.comment
    end
  end
end
