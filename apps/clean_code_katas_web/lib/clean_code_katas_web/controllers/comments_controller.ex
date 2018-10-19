defmodule KatasWeb.CommentsController do
  use KatasWeb, :controller

  alias Katas.Comments
  alias Katas.Challenges

  def create(conn, params) do
    %{user: user} = conn.assigns
    challenge = Challenges.get_challenge!(params["id"])
    comment = %{body: params["comment"]}

    with {:ok, _} <- Comments.create_challenge_comments(challenge, user, comment) do
      conn
      |> redirect(to: challenges_path(conn, :show, params["id"]))
    else
      _ ->
        IO.inspect("Implement error page")
    end
  end
end
