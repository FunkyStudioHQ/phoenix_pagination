# Phoenix.Pagination

Pagination for Ecto and Phoenix.


## Installation

The package is [available in Hex](https://hex.pm/packages/phoenix_pagination), the package can be installed as:

Add phoenix_pagination to your list of dependencies in `mix.exs`:
```elixir
def deps do
  [{:phoenix_pagination, "~> 0.0.1"}]
end
```

Add Phoenix.Pagination to your `repo.ex`:
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :testapp
  use Phoenix.Pagination, per_page: 2
end
```

## Usage
Start paginating your queries
```elixir
def index(conn, params) do
  {products, pagination} =
  Product
  |> Product.with_lowest_price
  |> Repo.paginate(params)

  render(conn, "index.html", products: products, pagination: pagination)
end
```

Add view helpers to your view
```elixir
defmodule MyApp.ProductView do
  use MyApp.Web, :view
  import Phoenix.Pagination.HTML
end
```

Generate the links using the view helpers
```elixir
<%= pagination @conn, @pagination, [current_class: "is-current"], fn p -> %>
<nav class="pagination" role="navigation" aria-label="pagination">
  <%= pagination_link p, :previous, label: "<< Newer", class: "pagination-previous", force_show: true %>
  <%= pagination_link p, :next, class: "pagination-next", force_show: true %>
  <ul class="pagination-list">
    <li><%= pagination_link p, :first, class: "pagination-link", force_show: true %></li>
    <%= for {pagenum, _, active} <- p.page_items do  %>
      <li><%= pagination_link p, pagenum, class: "pagination-link", current: active %></li>
    <% end %>
    <li><%= pagination_link p, :last, class: "pagination-link", force_show: true %></li>
  </ul>
</nav>
<% end %>
```

Building apis or SPA's, no problem Phoenix.Pagination has support for Json.

```elixir
defmodule MyApp.ProductView do
  use MyApp.Web, :view
  import Phoenix.Pagination.JSON

  def render("index.json", %{products: products, pagination: pagination, conn: conn}) do
    %{data: render_many(products, MyApp.ProductView, "product.json"),
      pagination: paginate(conn, pagination)}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      description: product.description,
      price: product.price}
  end
end
```


You can also send in options to paginate helper look at the docs for more details.

## Contributing

Please do send pull requests and bug reports, positive feedback is always welcome.


## Acknowledgement

This project comes from a [Kerosene](https://github.com/elixirdrops/kerosene) fork!

I would like to Thank

* elixirdrops (@elixirdrops)

## License

Please take a look at LICENSE.md
