# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :centralgps_webapi, CentralGPSWebAPI.Endpoint,
  url: [host: "localhost"],
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
    format: "$time [$level] $metadata - $message\n",
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
                 {LoggerFileBackend, :debug_log},
                 {LoggerFileBackend, :info_log},
                 {LoggerFileBackend, :warn_log},
                 {LoggerFileBackend, :error_log}]

  # Import environment specific config. This must remain at the bottom
  # of this file so it overrides the configuration defined above.
  import_config "#{Mix.env}.exs"
