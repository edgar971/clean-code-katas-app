defmodule KatasWeb.Plugs.SetPreviousPath do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _params) do
    conn
    |> put_session(:previous_path, conn.request_path)
  end
end
