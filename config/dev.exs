use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :centralgps_webapi, CentralGPSWebAPI.Endpoint,
  http: [port: 3001],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: []

# Watch static and templates for browser reloading.
config :centralgps_webapi, CentralGPSWebAPI.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :centralgps_webapi, CentralGPS.Repo,
  adapter: Ecto.Adapters.Postgres,
  extensions: [{CentralGPS.Repo.Extensions.Postgrex.JSON, library: Poison}],
  username: "postgres",
  password: "!pgsql@94#",
  database: "centralgps",
  hostname: "localhost",
  port: 6543
