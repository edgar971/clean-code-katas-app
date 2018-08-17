defmodule KatasWeb.Plugs.SetAuthUser do
  import Plug.Conn
  alias Katas.Accounts

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      user_id = get_session(conn, :user_id)

      cond do
        user = user_id && Accounts.get_user!(user_id) ->
          assign(conn, :user, user)
        true ->
          assign(conn, :user, nil)
      end
    end
  end
end