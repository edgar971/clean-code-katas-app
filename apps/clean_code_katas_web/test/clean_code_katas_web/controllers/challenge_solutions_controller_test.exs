defmodule KatasWeb.ChallengeSolutionsControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  describe "when user is not logged in" do
    test "redirects the user and adds error message", %{conn: conn} do
      conn = get(conn, challenge_solutions_path(conn, :index, 1))
      assert redirected_to(conn, 302)
      assert get_flash(conn, :error) == "You must be logged in."
    end
  end

  describe "when user is signed in" do
    test "renders form", %{conn: conn} do
      challenge = insert(:challenge)
      user = insert(:user)

      conn =
        conn
        |> assign(:user, user)
        |> get(challenge_solutions_path(conn, :index, challenge.id))

      assert html_response(conn, 200) =~ "Submitting solution to"
    end

    test "submitting a solution", %{conn: conn} do
      challenge = insert(:challenge)
      user = insert(:user)

      solution_form = %{
        description: "I did this because I thought it was cool",
        code: "function hello() {\n\talert('Hello world!');\n}"
      }

      conn =
        conn
        |> assign(:user, user)
        |> post(challenge_solutions_path(conn, :create, challenge.id, solution_form))

      assert redirected_to(conn, 302)
      assert get_flash(conn, :info) == "Your solution has been submitted"
    end
  end
end
