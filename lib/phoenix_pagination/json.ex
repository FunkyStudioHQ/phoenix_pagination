defmodule Phoenix.Pagination.JSON do
  use Phoenix.HTML
  import Phoenix.Pagination.Paginator, only: [build_options: 1]

  @moduledoc """
  JSON helpers to render the pagination links in json format.
  import the `Phoenix.Pagination.JSON` in your view module.

      defmodule MyApp.ProductView do
        use MyApp.Web, :view
        import Phoenix.Pagination.JSON

        def render("index.json", %{conn: conn, products: products, phoenix_pagination: phoenix_pagination}) do
          %{data: render_many(products, MyApp.ProductView, "product.json"),
            pagination: paginate(conn, phoenix_pagination)}
        end
      end


  Where `phoenix_pagination` is a `%Phoenix.Pagination{}` struct returned from `Repo.paginate/2`.

  `paginate` helper takes keyword list of `options`.
    paginate(phoenix_pagination, window: 5, next_label: ">>", previous_label: "<<", first: true, last: true, first_label: "First", last_label: "Last")
  """
  defmacro __using__(_opts \\ []) do
    quote do
      import Phoenix.Pagination.JSON
    end
  end

  def paginate(conn, paginator, opts \\ []) do
    opts = build_options(opts)

    Phoenix.Pagination.Paginator.paginate(conn, paginator, opts)
    |> render_page_list()
  end

  def render_page_list(page_list) do
    Enum.map(page_list, fn {link_label, page, url, current} ->
      %{label: "#{link_label}", url: url, page: page, current: current} 
    end)
  end
end