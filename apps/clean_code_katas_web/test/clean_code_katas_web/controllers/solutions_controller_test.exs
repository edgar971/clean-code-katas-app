defmodule KatasWeb.SolutionsControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  test "rendering a solutions page", %{conn: conn} do
    solution = insert(:solution)

    conn =
      conn
      |> get(solutions_path(conn, :show, solution.id))

    assert html_response(conn, 200) =~ solution.description
    assert html_response(conn, 200) =~ solution.challenge.title
  end
end
