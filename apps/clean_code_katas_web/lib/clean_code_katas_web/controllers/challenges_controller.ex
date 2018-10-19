defmodule KatasWeb.ChallengesController do
  use KatasWeb, :controller

  def index(conn, _params) do
    challenges = Katas.Challenges.list_challenges_with_solution_count()
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Katas.Challenges.get_challenge!(id)
    render(conn, "show.html", challenge: challenge)
  end
end
