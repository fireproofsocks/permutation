defmodule Permutation.MixProject do
  use Mix.Project

  @source_url "https://github.com/fireproofsocks/permutation"
  @version "0.3.0"

  def project do
    [
      aliases: aliases(),
      app: :permutation,
      deps: deps(),
      description: description(),
      docs: [
        main: "readme",
        source_ref: "v#{@version}",
        source_url: @source_url,
        logo: "logo.png",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        credo: :test,
        "local.hex": :prod,
        "local.rebar": :prod,
        "deps.get": :prod,
        test_reset: :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [
        tool: ExCoveralls
      ],
      version: @version
    ]
  end

  defp aliases do
    [
      lint: ["format --check-formatted", "credo --strict"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7.18", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4.7", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.40.1", runtime: false},
      {:excoveralls, "~> 0.18.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp description,
    do: """
    Permutation is a package and protocol for calculating the possible
    permutations or combinations of an Enumerable.
    """

  def links do
    %{
      "GitHub" => @source_url,
      "Readme" => "#{@source_url}/blob/v#{@version}/README.md",
      "Changelog" => "#{@source_url}/blob/v#{@version}/CHANGELOG.md"
    }
  end

  defp package do
    [
      maintainers: ["Everett Griffiths"],
      licenses: ["Apache-2.0"],
      logo: "assets/logo.png",
      links: links(),
      files: [
        "lib",
        "logo.png",
        "mix.exs",
        "README*",
        "CHANGELOG*",
        "LICENSE*"
      ]
    ]
  end
end
