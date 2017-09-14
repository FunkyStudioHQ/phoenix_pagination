use Mix.Config

config :phoenix_pagination, ecto_repos: [Phoenix.Pagination.Repo]

config :phoenix_pagination, Phoenix.Pagination.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_pagination_dev",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# shut up only log errors
config :logger, :console,
  level: :error
