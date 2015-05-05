use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :centralgps_webapi, CentralGPSWebAPI.Endpoint,
  http: [port: 4123],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :centralgps_webapi, CentralGPSWebAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "!pgsql@94#",
  database: "centralgps",
  size: 1,
  max_overflow: false
