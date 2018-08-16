use Mix.Config

config :clean_code_katas, ecto_repos: [Katas.Repo]

import_config "#{Mix.env}.exs"
