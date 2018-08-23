defmodule KatasWeb.ChallengesController do
  use KatasWeb, :controller

  def index(conn, _params) do
    challenges = Katas.Challenges.list_challenges()
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Katas.Challenges.get_challenge!(id) |> Katas.Repo.preload(:solutions)
    render(conn, "show.html", challenge: challenge)
  end
end
