defmodule KatasWeb.Router do
  use KatasWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(KatasWeb.Plugs.SetAuthUser)
    plug(KatasWeb.Plugs.SetPreviousPath)
  end

  pipeline :auth do
    plug(KatasWeb.Plugs.RequireAuth)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KatasWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/login", AuthController, :index)
    get("/challenges", ChallengesController, :index)
    get("/challenges/:id", ChallengesController, :show)
    get("/solutions/:id", SolutionsController, :show)
  end

  scope "/", KatasWeb do
    pipe_through([:browser, :auth])

    get("/challenges/:id/solution", ChallengeSolutionsController, :index)
    post("/challenges/:id/solution", ChallengeSolutionsController, :create)

    post("/votes/:solution_id", VotesController, :create)
  end

  scope "/auth", KatasWeb do
    pipe_through(:browser)

    get("/signout", AuthController, :delete)
    get("/github", AuthController, :request)
    get("/github/callback", AuthController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", KatasWeb do
  #   pipe_through :api
  # end
end
