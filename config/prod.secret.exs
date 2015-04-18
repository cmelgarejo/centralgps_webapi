use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :centralgps_webapi, CentralGPSWebAPI.Endpoint,
  secret_key_base: "mIalQMg+igBwsWTmSR2i0zaLTl5o3yKV8gpnWekNV/eVXXxaf5Hl3CYxDKLsV7b8"

# Configure your database
config :centralgps_webapi, CentralGPS.Repo,
  adapter: Ecto.Adapters.Postgres,
  extensions: [{CentralGPS.Repo.Extensions.Postgrex.JSON, library: Poison}],
  username: "centralgps",
  password: "!cgps#master_centralgps#1402$",
  database: "centralgps",
  hostname: "localhost",
  port: 6543
