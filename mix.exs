defmodule CentralGPSWebAPI.Mixfile do
  use Mix.Project

  def project do
    [app: :central_g_p_s_web_a_p_i,
     version: "1.0.1",
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
    apps = [:phoenix, :cowboy, :logger, :logger_file_backend, :postgrex, :ecto ]
    dev_apps = Mix.env == :dev && [ :reprise ] || []
    [ mod: {CentralGPSWebAPI, []}, applications: dev_apps ++ apps ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:exrm,                github: "bitwalker/exrm"},
     {:reprise,             github: "herenowcoder/reprise", only: :dev},
     {:logger_file_backend, github: "onkel-dirtus/logger_file_backend"},
     {:phoenix,             "~> 0.13"},
     {:phoenix_live_reload, "~> 0.4"},
     {:phoenix_ecto,        "~> 0.4"},
     {:phoenix_html,        "~> 1.0"},
     {:postgrex,            ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.3"},
     {:cowboy,              "~> 1.0"}]
  end
end
