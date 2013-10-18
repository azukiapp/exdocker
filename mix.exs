defmodule Docker.Mixfile do
  use Mix.Project

  def project do
    [ app: :exdocker,
      version: "0.0.1",
      elixir: "~> 0.10.3",
      deps: deps,
      configs: [
        docker_host: {:from_env, :DOCKER_HOST, "http://localhost:4243"}
      ]]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:httpotion] ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:jsx , github: "talentdeficit/jsx", compile: "rebar compile" },
      {:httpotion, github: "myfreeweb/httpotion", branch: "master"},
      {:tree_config, github: "nuxlli/tree_config"},
    ]
  end
end
