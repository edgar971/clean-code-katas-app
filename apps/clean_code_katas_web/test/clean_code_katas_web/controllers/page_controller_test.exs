defmodule KatasWeb.PageControllerTest do
  use KatasWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Clean Code Katas"
  end
end
