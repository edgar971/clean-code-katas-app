use Mix.Config

config :clean_code_katas, ecto_repos: [Katas.Repo]

config :clean_code_katas, :comeonin, Comeonin.Bcrypt

import_config "#{Mix.env}.exs"
