defmodule Phoenix.PaginationTest do
  use ExUnit.Case
  alias Phoenix.Pagination.Repo
  alias Phoenix.Pagination.Product

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Phoenix.Pagination.Repo)
  end

  defp create_products do
    for _ <- 1..15 do
      %Product { name: "Product 1", price: 100.00 }
      |> Repo.insert!
    end
  end

  test "per_page option" do
    create_products()
    {_items, phoenix_pagination} = Product |> Repo.paginate(%{}, per_page: 5)
    assert phoenix_pagination.per_page == 5
  end

  test "per_page default option" do
    create_products()
    {items, phoenix_pagination} = Product |> Repo.paginate(%{}, per_page: nil)
    assert length(items) == 10
    assert phoenix_pagination.total_pages == 2
    assert phoenix_pagination.total_count == 15
  end

  test "total pages based on per_page" do
    create_products()
    {_items, phoenix_pagination} = Product |> Repo.paginate(%{}, per_page: 5)
    assert phoenix_pagination.total_pages == 3
  end

  test "default config" do
    create_products()
    {items, phoenix_pagination} = Product |> Repo.paginate(%{})
    assert phoenix_pagination.total_pages == 2
    assert phoenix_pagination.page == 1
    assert length(items) == 10
  end

  test "total pages calculation" do
    row_count = 100
    per_page = 10
    total_pages = 10
    assert Phoenix.Pagination.get_total_pages(row_count, per_page) == total_pages
  end

  test "total_count option" do
    create_products()
    {_items, phoenix_pagination} = Product |> Repo.paginate(%{}, total_count: 3, per_page: 5)
    assert phoenix_pagination.total_count == 3
    assert phoenix_pagination.total_pages == 1
  end

  test "page offset constraint" do
    create_products()
    {_items, phoenix_pagination} = Product |> Repo.paginate(%{"page" => 100}, total_count: 3, per_page: 5, max_page: 10)
    assert phoenix_pagination.total_count == 3
    assert phoenix_pagination.total_pages == 1
    assert phoenix_pagination.page == 10
  end

  test "fallbacks to count query when provided total_count is nil" do
    create_products()
    {_items, phoenix_pagination} = Product |> Repo.paginate(%{}, total_count: nil, per_page: 5)
    assert phoenix_pagination.total_count == 15
    assert phoenix_pagination.total_pages == 3
  end

  test "to_integer returns number" do
    assert Phoenix.Pagination.to_integer(10) == 10
    assert Phoenix.Pagination.to_integer("10") == 1
    assert Phoenix.Pagination.to_integer(nil) == 1
  end
end
