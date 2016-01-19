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
      {row_count, result} = fn_chkapi_roadmaps ([ params._auth_token, params.day ])
      if row_count < 1, do: {conn, result} = {(conn |> put_status(204)), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

end
