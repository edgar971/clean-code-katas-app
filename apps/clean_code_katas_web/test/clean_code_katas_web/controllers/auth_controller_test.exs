defmodule KatasWeb.AuthControllerTest do
  use KatasWeb.ConnCase
  alias Katas.Accounts
  import KatasWeb.Factory

  @ueberauth_auth %{
    credentials: %{token: "ldoeorufhmdodptoken"},
    info: %{email: "tonystark@example.com", name: "Tony Stark"},
    provider: :github
  }

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "Login"
  end

  test "redirects user to Github for authentication", %{conn: conn} do
    conn = get(conn, "/auth/github?scope=user,public_repo")
    assert redirected_to(conn, 302)
  end

  test "creates user from Github login", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/github/callback")

    assert Enum.count(Accounts.list_users()) == 1
    assert get_flash(conn, :info) == "Thank you for singing in with Github!"
  end

  test "signs out user", %{conn: conn} do
    user = insert(:user)

    conn =
      conn
      |> assign(:user, user)
      |> get("/auth/signout")
      |> get("/")

    assert conn.assigns.user == nil
  end
end
