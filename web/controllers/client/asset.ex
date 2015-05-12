defmodule CentralGPSWebAPI.Controllers.Client.Asset do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.Asset.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def client_asset_list(conn, params) do
    try do
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = fn_api_client_asset_list([params._auth_token, params.zzz_offset, params.zzzz_limit])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
