defmodule CentralGPSWebAPI.Controllers.Device.Roadmaps do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def roadmaps(conn, params) do
    try do
      keys = [ :day ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |>  Map.update(:day, nil, &(parse_date(&1)))
      {_, result} = fn_chkapi_roadmaps ([ params._auth_token, params.day ])
      response_code = if result.status, do: 201, else: 200
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
