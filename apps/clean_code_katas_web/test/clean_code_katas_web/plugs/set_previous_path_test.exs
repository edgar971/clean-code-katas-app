defmodule Katas.Plugs.SetPreviousPathTest do
  use KatasWeb.ConnCase

  setup do
    request_path = "/best/path/ever"

    conn =
      build_conn(:get, request_path)
      |> Plug.Test.init_test_session(%{})
      |> KatasWeb.Plugs.SetPreviousPath.call(%{})

    {:ok, conn: conn}
  end

  test "setting the previous_path", %{conn: conn} do
    assert get_session(conn, :previous_path) == conn.request_path
  end
end
