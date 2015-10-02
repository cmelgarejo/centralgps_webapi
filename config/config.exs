# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# TODO: change :central_g_p_s_web_a_p_i to :centralgps_webapi
# Configures the endpoint
config :central_g_p_s_web_a_p_i, CentralGPSWebAPI.Endpoint,
  url: [host: "api.centralgps.net"],
  # Uncomment on prod server & delete the next line of the same config
  #root: "/usr/bin/central_g_p_s_web_a_p_i/lib/central_g_p_s_web_a_p_i-1.2.0",
  root: Path.expand("..", __DIR__),
  secret_key_base: "aLIFKvszPTOoXoAYQ3RL9qdUfmhEyEesWFMi5OwQd80sME26l3tyrZzb9digCZXj",
  debug_errors: false,
  code_reloader: false,
  server: true
  #pubsub: [name: CentralGPSWebAPI.PubSub,
  #         adapter: Phoenix.PubSub.PG2]

  # Configures Elixir's Logger
  config :logger, utc_log: true

  config :logger, :console,
    format: "$date $time [$level] $metadata - $message\n",
    metadata: [:request_id]

  config :logger, :debug_log,
    path: "logs/debug.log",
    level: :debug

  config :logger, :error_log,
    path: "logs/error.log",
    level: :error

  config :logger, :info_log,
    path: "logs/info.log",
    level: :info

  config :logger, :warn_log,
    path: "logs/warn.log",
    level: :warn

  config :logger,
      backends: [:console,
      {LoggerFileBackend, :error_log},
      {LoggerFileBackend, :warn_log},
      {LoggerFileBackend, :info_log},
      {LoggerFileBackend, :debug_log}]

  # Import environment specific config. This must remain at the bottom
  # of this file so it overrides the configuration defined above.
  import_config "#{Mix.env}.exs"
