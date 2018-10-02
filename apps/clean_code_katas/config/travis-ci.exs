use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :clean_code_katas, Katas.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "clean_code_katas_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox