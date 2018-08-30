defmodule KatasWeb.ChallengeSolutionsControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  describe "when user is not logged in" do
    test "redirects the user and adds error message", %{conn: conn} do
      solution = insert(:solution)

      conn = get(conn, challenge_solutions_path(conn, :index, solution.challenge.id))
      assert redirected_to(conn, 302)
      assert get_flash(conn, :error) == "You must be logged in."
    end
  end

  describe "when user is signed in" do
    test "renders form", %{conn: conn} do
      solution = insert(:solution)
      user = insert(:user)

      conn =
        conn
        |> assign(:user, user)
        |> get(challenge_solutions_path(conn, :index, solution.challenge.id))

      assert html_response(conn, 200) =~ "Submit Your Solution"
    end
  end
end
