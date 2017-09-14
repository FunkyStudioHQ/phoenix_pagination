defmodule Phoenix.Pagination.PaginatorModesTest do
  use ExUnit.Case, async: true
  import Phoenix.Pagination.Paginator

  @simple_mode_opts  [mode: :simple]
  @default_mode_opts []

  test "generates only next page" do
    current_page = 1
    pagination = list_for_page(current_page, @simple_mode_opts)
    assert length(pagination) == 1
  end

  test "generates previous and next pages" do
    current_page = 2
    pagination = list_for_page(current_page, @simple_mode_opts)
    assert length(pagination) == 2
  end

  test "generates only previous page" do
    current_page = 5
    pagination = list_for_page(current_page, @simple_mode_opts)
    assert length(pagination) == 1
  end

  test "uses mode from config" do
    Application.put_env(:phoenix_pagination, :mode, :simple)
    current_page = 5
    pagination = list_for_page(current_page, @default_mode_opts)
    assert length(pagination) == 1
  end

  defp list_for_page(page_num, opts) do
    conn = %{request_path: "http://localhost:4000/products"}
    paginator = %Phoenix.Pagination{items: [], per_page: 10, page: page_num, total_pages: 5, total_count: 0, params: %{}}
    paginate(conn, paginator, build_options(opts))
  end
end
