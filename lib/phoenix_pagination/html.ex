defmodule Phoenix.Pagination.HTML do
  use Phoenix.HTML
  alias Phoenix.Pagination.HTML
  import Phoenix.Pagination.Paginator, only: [build_options: 1]

  @buttons_labels ~w(first previous next last)a

  defmacro __using__(_opts \\ []) do
    quote do
      import Phoenix.Pagination.HTML
    end
  end

  def pagination(conn, paginator, opts \\ [], fun) do
    opts = build_options(opts)

    page_list = conn
    |> Phoenix.Pagination.Paginator.paginate(paginator, opts)

    %{
      options: opts,
      all_links: page_list,
      page_items: list_links(page_list)
    } |> fun.()
  end

  def pagination_link(pagination, name, opts \\ []) do
    options = pagination.options ++ opts
    |> build_options

    pagination.all_links
    |> Enum.filter(fn{pagenum, _, _, _}-> pagenum === name end)
    |> build_link(name, options)
  end

  defp build_link(button, name, opts) when length(button) == 0 do
    case opts[:force_show] do
      true -> link text_label(name, opts[:label]), to: "", class: opts[:class], disabled: "disabled"
        _  -> nil
    end
  end
  defp build_link(button, name, opts \\ []) do
    [{name, _,url, current}] = button
    link text_label(name, opts[:label]), to: url, class: css_class(current, opts)
  end

  defp text_label(name, nil), do: to_string(name)
  defp text_label(_, label), do: label


  defp list_links(page_list) do
    page_list
    |> Enum.filter(fn{label, _, _, _}-> !Enum.member?(@buttons_labels, label) end)
    |> Enum.map(fn{label, _, url, current}-> {label, url, current} end)
  end

  defp css_class(true, opts), do: "#{opts[:class]} #{opts[:current_class]}"
  defp css_class(false, opts), do: opts[:class]
end
