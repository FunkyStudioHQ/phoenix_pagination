# Phoenix.Pagination

Simple pagination for Ecto and Phoenix using plaing EEx templates. It is based on a fork of [Kerosene](https://github.com/elixirdrops/kerosene), we think that pagination markup should be handled in templates, rather than with helper functions. So, here it comes.

## Installation

If [available in Hex](https://hex.pm/packages/phoenix_pagination), can be installed as:

Add phoenix_pagination to your list of dependencies in `mix.exs`:
```elixir
def deps do
  [{:phoenix_pagination, "~> 0.5.0"}]
end
```

Add Phoenix.Pagination to your `repo.ex`:
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :testapp
  use Phoenix.Pagination, per_page: 15
end
```

## Usage
Start paginating your queries
```elixir
def index(conn, params) do
  {products, pagination} =  Product
  |> Product.with_lowest_price
  |> Repo.paginate(params)

  render(conn, "index.html", products: products, pagination: pagination)
end
```

Add view helpers to your view
```elixir
defmodule MyAppWeb.ProductView do
  use MyAppWeb, :view
  import Phoenix.Pagination.HTML
end
```

Create your pagination template in `lib/my_app_web/templates/pagination/pagination.html.eex`
```elixir
<%= pagination @conn, @pagination, [current_class: "is-current"], fn p -> %>
  <nav class="pagination" role="navigation" aria-label="pagination">
    <ul class="pagination-list">
      <li><%= pagination_link p, :first, label: gettext("First"), class: "pagination-link", force_show: true %></li>
      <%= for {pagenum, _, active} <- p.page_items do  %>
        <li><%= pagination_link p, pagenum, class: "pagination-link", current: active %></li>
      <% end %>
      <li><%= pagination_link p, :last, label: gettext("Last"), class: "pagination-link", force_show: true %></li>
    </ul>
  </nav>
<% end %>
```

You can have as many pagination templates as you want (even with custom filenames), and render it where you need:
```elixir
<%= render MyAppWeb.PaginationView, "pagination.html", conn: @conn, pagination: @pagination %>
```

Building APIs or SPAs? no problem Phoenix.Pagination has support for Json.

```elixir
defmodule MyAppWeb.ProductView do
  use MyAppWeb, :view
  import Phoenix.Pagination.JSON

  def render("index.json", %{products: products, pagination: pagination, conn: conn}) do
    %{data: render_many(products, MyAppWeb.ProductView, "product.json"),
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

We would like to thank

* elixirdrops ([@elixirdrops](https://github.com/elixirdrops))
* [Kerosene](https://github.com/elixirdrops/kerosene)

## License

Please take a look at LICENSE.md
