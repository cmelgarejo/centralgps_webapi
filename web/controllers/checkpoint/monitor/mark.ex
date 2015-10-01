defmodule CentralGPSWebAPI.Controllers.Checkpoint.Mark do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Mark.Functions
  import CentralGPS.Repo.Utilities


  def mark_list(conn, params) do
    try do
      keys = [ :asset_id, :init_at, :stop_at ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:asset_id, nil, &(parse_int(&1)))
        |> Map.update(:init_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:stop_at,  nil, &(parse_datetime(&1)))
        |> Map.values
        |> fn_api_monitor_mark_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
