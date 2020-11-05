defmodule Skrap.MixProject do
  use Mix.Project

  def project do
    [
      app: :skrap,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        force_check: true,
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.13.2", only: :test},
      {:faker, "~> 0.15", only: :test},
      {:floki, "~> 0.29.0"},
      {:hackney, "~> 1.16.0"},
      {:tesla, "~> 1.3.0"}
    ]
  end
end
