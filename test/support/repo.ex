defmodule Phoenix.Pagination.Repo do
  use Ecto.Repo,
      otp_app: :phoenix_pagination,
      adapter: Ecto.Adapters.Postgres

  use Phoenix.Pagination,
      otp_app: :phoenix_pagination,
      per_page: 10
end
