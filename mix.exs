defmodule EntrepotEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :entrepot_ecto,
      version: "0.10.0",
      description: "Ecto integration for Entrepôt",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "EntrepotEcto",
      source_url: "https://github.com/bonfire-networks/entrepot_ecto",
      package: package()
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
      # {:entrepot, "~> 0.10"},
      {:entrepot, path: "../entrepot"},
      {:ecto, "~> 3.10"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Bonfire Networks"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/bonfire-networks/entrepot_ecto"}
    ]
  end
end
