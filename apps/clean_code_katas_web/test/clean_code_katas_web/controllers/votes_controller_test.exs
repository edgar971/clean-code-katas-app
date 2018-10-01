defmodule KatasWeb.VotesControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  alias Katas.Challenges

  describe "when user is not logged in" do
    test "redirects the user and adds error message", %{conn: conn} do
      solution = insert(:solution)

      conn = post(conn, votes_path(conn, :create, solution.id))
      assert redirected_to(conn, 302)
      assert get_flash(conn, :error) == "You must be logged in."
    end
  end

  describe "when user is logged it" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, conn: assign(conn, :user, user)}
    end

    test "adds vote to a user solution", %{conn: conn} do
      solution = insert(:solution)

      conn = post(conn, votes_path(conn, :create, solution.id))

      assert Challenges.get_solution_votes(solution.id) == 1
      assert redirected_to(conn, 302) == solutions_path(conn, :show, solution.id)
    end
  end
end
