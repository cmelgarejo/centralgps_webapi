defmodule CentralGPSWebAPI.Endpoint do
  use Phoenix.Endpoint, otp_app: :central_g_p_s_web_a_p_i

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/api/v1/", from: :central_g_p_s_web_a_p_i,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_centralgps_webapi_key",
    signing_salt: "cdVIIJPy"

  plug CentralGPSWebAPI.Router
end
