use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
config :central_g_p_s_web_a_p_i, CentralGPSWebAPI.Endpoint,
  http: [port: 4000], #port: {:system, "PORT"} && 4000],
  url:  [host: "api.centralgps.net"],
  debug_errors: false,
  root: "/usr/bin/central_g_p_s_web_a_p_i/lib/central_g_p_s_web_a_p_i-1.2.1",
  cache_static_manifest: "priv/static/manifest.json"
# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config:central_g_p_s_web_a_p_i, CentralGPSWebAPI.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

# Do not print debug messages in production
#config :logger, level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :central_g_p_s_web_a_p_i, CentralGPSWebAPI.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"
