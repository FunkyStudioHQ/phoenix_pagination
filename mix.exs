defmodule Phoenix.Pagination.Mixfile do
  use Mix.Project
  @version "0.5.0"

  def project do
    [app: :phoenix_pagination,
     version: @version,
     elixir: "~> 1.4",
     elixirc_paths: path(Mix.env),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases(),
     name: "phoenix_pagination",
     docs: [source_ref: "v#{@version}", main: "phoenix_pagination"],
     source_url: "https://github.com/FunkyStudioHQ/phoenix_pagination.git",
     description: """
     Simple pagination for Ecto and Phoenix using plaing EEx templates.
     """]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: application(Mix.env)]
  end
  defp application(:test), do: [:postgrex, :ecto, :logger]
  defp application(_), do: [:logger]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:phoenix_html, "~> 2.10"},
      {:plug, "~> 1.4"},
      {:ecto, "~> 2.2"},
      # Test dependencies
      {:postgrex, ">= 0.0.0", only: [:test]},
      {:credo, "~> 0.8", only: [:dev, :test]},
      # Docs dependencies
      {:earmark, "~> 1.1", only: :docs},
      {:ex_doc, "~> 0.17", only: :docs},
      {:inch_ex, "~> 0.5", only: :docs}
    ]
  end

  defp path(:test) do
    ["lib", "test/support", "test/fixtures"]
  end
  defp path(_), do: ["lib"]

  defp package do
    [
      maintainers: ["FunkyStudio"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/FunkyStudioHQ/phoenix_pagination.git",
        "Documentation" => "https://hexdocs.pm/phoenix_pagination",
        "FunkyStudio" => "https://funky.studio"
      },
      files: ~w(lib test config) ++ ~w(CHANGELOG.md LICENSE.md mix.exs README.md)
    ]
  end

  def aliases do
    ["test": ["ecto.create --quite", "ecto.migrate --quite", "test"]]
  end
end
