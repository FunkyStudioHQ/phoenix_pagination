defmodule Phoenix.Pagination.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string
    field :price, :decimal

    timestamps
  end
end