defmodule KatasWeb.ChallengeSolutionsController do
  use KatasWeb, :controller
  alias Katas.Challenges

  def index(conn, %{"id" => id}) do
    challenge = Challenges.get_challenge!(id)
    render(conn, "index.html", challenge: challenge)
  end

  def create(conn, %{"id" => challenge_id} = params) do
    challenge = Challenges.get_challenge!(challenge_id)
    %{assigns: %{user: user}} = conn

    solution_changeset = %{
      description: params["description"],
      code: params["code"],
      user_id: user.id,
      challenge_id: challenge.id
    }

    with {:ok, solution} <- Challenges.create_solution(solution_changeset) do
      conn
      |> put_flash(:info, "Your solution has been submitted")
      |> redirect(to: solutions_path(conn, :show, solution.id))
    else
      _ ->
        IO.inspect("Implement error page")
    end

    # render(conn, "index.html")
  end
end
