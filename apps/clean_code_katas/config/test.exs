use Mix.Config

# Configure your database
config :clean_code_katas, Katas.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "clean_code_katas_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox