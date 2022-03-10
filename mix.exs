defmodule Permutation.MixProject do
  use Mix.Project

  @source_url "https://github.com/fireproofsocks/permutation"
  @version "0.1.0"

  def project do
    [
      aliases: aliases(),
      app: :permutation,
      version: @version,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        source_ref: "v#{@version}",
        source_url: @source_url,
        logo: "logo.png",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      test_coverage: [
        tool: ExCoveralls
      ],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        credo: :test,
        "local.hex": :prod,
        "local.rebar": :prod,
        "deps.get": :prod,
        test_reset: :test
      ]
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
      {:dialyxir, "~> 1.1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.6.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.26.0", runtime: false},
      {:excoveralls, "~> 0.14.0", only: [:dev, :test], runtime: false}
    ]
  end
end
