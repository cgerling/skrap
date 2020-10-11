defmodule Skrap.MixProject do
  use Mix.Project

  def project do
    [
      app: :skrap,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [{:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false}]
  end
end
