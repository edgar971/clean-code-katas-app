defmodule KatasWeb.SolutionsController do
  use KatasWeb, :controller

  def show(conn, %{"id" => id}) do
    solution = Katas.Challenges.get_solution!(id)
    render(conn, "index.html", solution: solution)
  end
end
