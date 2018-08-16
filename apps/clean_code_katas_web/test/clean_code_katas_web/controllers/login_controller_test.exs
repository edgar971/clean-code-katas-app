defmodule KatasWeb.AuthControllerTest do
  use KatasWeb.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get conn, "/login"
    assert html_response(conn, 200) =~ "Login"
  end
end
