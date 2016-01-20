defmodule CentralGPSWebAPI.Mixfile do
  use Mix.Project

  def project do
    [app: :central_g_p_s_web_a_p_i,
     version: "1.2.1",
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
      licenses: ["Licensed Closed Source"],
      links: %{"GitLab" => "https://gitlab.com/CentralGPS/checkpoint_api"} ]
  end

  def application do
    apps = [ :connection, :cowboy, :ecto, :httpoison, :logger, :logger_file_backend, :phoenix, :phoenix_html, :phoenix_ecto, :postgrex ]
    dev_apps = Mix.env == :dev && [ :reprise ] || []
    [ mod: {CentralGPSWebAPI, []}, applications: dev_apps ++ apps ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      #{:cowboy,              github: "ninenines/cowboy", override: true}
      {:cowboy,               "~> 1.0"},
      {:exrm,                 github: "bitwalker/exrm"},
      #{:conform,              github: "bitwalker/conform", only: :dev}, #only good to create the onfig schema and .conf file
      {:httpoison,            github: "edgurgel/httpoison"},
      {:logger_file_backend,  github: "onkel-dirtus/logger_file_backend"},
      {:phoenix,              github: "phoenixframework/phoenix", override: true},
      {:phoenix_live_reload,  github: "phoenixframework/phoenix_live_reload", only: :dev},
      {:phoenix_html,         github: "phoenixframework/phoenix_html", override: true},
      #{:phoenix_html,        "~> 1.4"},
      {:phoenix_ecto,         github: "phoenixframework/phoenix_ecto"},
      #{:phoenix_ecto,        "~> 0.8"},
      #{:postgrex,             github: "ericmj/postgrex", override: true}, #Still no fix for Postgrex.Connection (19/1/2016)
      {:postgrex,             ">= 0.0.0"}, #0.10.0 Still uses :connection fix on apps list
      {:reprise,              github: "herenowcoder/reprise", only: :dev}
    ]
  end
end
