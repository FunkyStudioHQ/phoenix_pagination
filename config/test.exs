import Config

config :phoenix_pagination, ecto_repos: [Phoenix.Pagination.Repo]

config :phoenix_pagination, Phoenix.Pagination.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASSWORD"),
  database: "phoenix_pagination_dev",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: "5432"

# shut up only log errors
config :logger, :console,
  level: :error
