defmodule KatasWeb.VotesController do
  use KatasWeb, :controller
  alias Katas.Challenges

  def create(%{assigns: %{user: user}} = conn, %{"solution_id" => solution_id}) do
    with {:ok, _} <- Challenges.upvote_solution(user.id, solution_id) do
      conn
      |> redirect(to: solutions_path(conn, :show, solution_id))
    end
  end
end
