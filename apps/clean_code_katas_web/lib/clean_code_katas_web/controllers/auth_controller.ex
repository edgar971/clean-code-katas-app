defmodule KatasWeb.AuthController do
  use KatasWeb, :controller
  plug(Ueberauth)

  alias Katas.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_changeset = %{
      name: auth.info.name,
      credential: %{email: auth.info.email, token: auth.credentials.token, provider: "github"}
    }

    case Accounts.create_or_update_user(user_changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thank you for singing in with Github!")
        |> put_session(:user_id, user.id)
        |> redirect(to: page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
