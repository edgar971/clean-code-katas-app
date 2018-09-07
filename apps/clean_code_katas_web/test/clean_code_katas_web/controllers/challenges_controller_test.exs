defmodule KatasWeb.ChallengesControllerTest do
  use KatasWeb.ConnCase
  import KatasWeb.Factory

  test "GET /challenges", %{conn: conn} do
    challenges = [insert(:challenge)]

    conn = get(conn, challenges_path(conn, :index), challenges: challenges)
    assert html_response(conn, 200) =~ "Some cool challenge"
  end

  test "GET /challenges/:id for a single challenge", %{conn: conn} do
    challenge = insert(:challenge)
    conn = get(conn, challenges_path(conn, :show, challenge.id))
    assert html_response(conn, 200) =~ challenge.description
  end
end
