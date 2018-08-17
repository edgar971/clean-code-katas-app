defmodule KatasWeb.Router do
  use KatasWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(KatasWeb.Plugs.SetAuthUser)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KatasWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/login", AuthController, :index)
  end

  scope "/auth", KatasWeb do
    pipe_through(:browser)

    get "/signout", AuthController, :delete
    get("/github", AuthController, :request)
    get("/github/callback", AuthController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", KatasWeb do
  #   pipe_through :api
  # end
end
