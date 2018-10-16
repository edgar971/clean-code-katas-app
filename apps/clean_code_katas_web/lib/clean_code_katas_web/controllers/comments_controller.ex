defmodule KatasWeb.CommentsController do
  use KatasWeb, :controller

  alias Katas.Comments

  def create(conn, params) do
    %{id: user_id} = conn.assigns.user
    comment = %{body: params["comment"], challenge_id: params["id"], user_id: user_id}

    with {:ok, _} <- Comments.create_challenge_comments(comment) do
      conn
      |> redirect(to: get_session(conn, :previous_path))
    else
      _ ->
        IO.inspect("Implement error page")
    end
  end
end
