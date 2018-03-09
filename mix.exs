defmodule RavenxChat.MixProject do
  use Mix.Project

  def project do
    [
      app: :ravenx_chat,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
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
      {:ravenx, "~> 1.1 or ~> 2.0"},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:httpoison, "~> 0.12 or ~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: "https://github.com/jeromedoyle/ravenx_chat",
      extras: ["README.md"]
    ]
  end

  defp description do
    """
    Ravenx strategy to send notifications to Hangouts Chat.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :ravenx_chat,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jerome Doyle"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jeromedoyle/ravenx_chat"}
    ]
  end
end
