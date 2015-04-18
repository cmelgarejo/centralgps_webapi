defmodule CentralGPSWebAPI.Mixfile do
  use Mix.Project

  def project do
    [app: :centralgps_webapi,
     version: "1.0.0",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  defp package do
    [ contributors: ["cmelgarejo"],
      licenses: ["Pay Licensed Viewable-Source"],
      links: %{"GitLab" => "https://gitlab.com/CentralGPS/centralgps_webapi"} ]
  end

  def application do
    apps = [:phoenix, :cowboy, :logger, :logger_file_backend, :postgrex, :ecto ]
    dev_apps = Mix.env == :dev && [ :reprise ] || []
    [ mod: {CentralGPSWebAPI, []}, applications: dev_apps ++ apps ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:reprise,             github: "herenowcoder/reprise", only: :dev},
     {:logger_file_backend, github: "onkel-dirtus/logger_file_backend"},
     {:exrm,                github: "bitwalker/exrm"},
     {:postgrex,            github: "ericmj/postgrex", override: true},
     {:phoenix,             github: "phoenixframework/phoenix", override: true},
     {:phoenix_ecto,        github: "phoenixframework/phoenix_ecto", override: true},
     #{:phoenix_live_reload, github: "phoenixframework/phoenix_live_reload", override: true},
     {:cowboy,              "~> 1.0"}]
  end
end
