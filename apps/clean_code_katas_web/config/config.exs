# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :clean_code_katas_web,
  namespace: KatasWeb,
  ecto_repos: [Katas.Repo]

# Configures the endpoint
config :clean_code_katas_web, KatasWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0l9+cM8YIeteh4fANki45xrKKLNMMshLCHFhkf7Oz1klTNIYoo21eQkH8hXQJc6b",
  render_errors: [view: KatasWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KatasWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :clean_code_katas_web, :generators, context_app: :clean_code_katas

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
