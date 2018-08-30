defmodule KatasWeb.ChallengeSolutionsController do
  use KatasWeb, :controller

  def index(conn, %{"id" => id}) do
    render(conn, "index.html")
  end
end
