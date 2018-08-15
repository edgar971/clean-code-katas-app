use Mix.Config

# Configure your database
config :clean_code_katas, Katas.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "clean_code_katas_dev",
  hostname: "localhost",
  pool_size: 10
