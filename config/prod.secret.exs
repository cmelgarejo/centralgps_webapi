use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :central_g_p_s_web_a_p_i, CentralGPSWebAPI.Endpoint,
  secret_key_base: "mIalQMg+igBwsWTmSR2i0zaLTl5o3yKV8gpnWekNV/eVXXxaf5Hl3CYxDKLsV7b8"

# Configure your database
config :central_g_p_s_web_a_p_i, CentralGPS.Repo,
  adapter: Ecto.Adapters.Postgres,
  extensions: [{CentralGPS.Repo.Extensions.Postgrex.JSON, library: Poison}],
  username: "centralgps",
  password: "!cgps#master_centralgps#1402$",
  database: "centralgps",
  hostname: "localhost",
  port: 6543
