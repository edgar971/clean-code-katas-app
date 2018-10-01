defmodule KatasWeb.SolutionsController do
  use KatasWeb, :controller

  def show(conn, %{"id" => id}) do
    solution = Katas.Challenges.get_solution!(id)
    number_of_votes = Katas.Challenges.get_solution_votes(id)

    render(conn, "index.html", solution: solution, number_of_votes: number_of_votes)
  end
end
