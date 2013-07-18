defmodule Docker.Mixfile do
  use Mix.Project

  def project do
    [ app: :exdocker,
      version: "0.0.1",
      elixir: "~> 0.10.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:httpotion],
      env: [
        docker_host: {:from_env, :DOCKER_HOST, "http://localhost:4243"},
      ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:jsx, "1.4.1", [github: "talentdeficit/jsx", tag: "v1.4.1"]},
      {:httpotion, "0.2.0", [github: "myfreeweb/httpotion", branch: "master"]}
    ]
  end
end