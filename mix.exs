defmodule Octograph.Mixfile do
  use Mix.Project

  def project do
    [app: :octograph,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Octograph, []},
     applications: [:phoenix, :cowboy, :logger, :tentacat, :ecto]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.11"},
     {:phoenix_ecto, "~> 0.3"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.3"},
     {:cowboy, "~> 1.0"},
     {:espec, "~> 0.4.1"},
     {:tentacat, github: "antonmi/tentacat"},
     {:mongo, "~> 0.5.0"}
   ]
  end
end
