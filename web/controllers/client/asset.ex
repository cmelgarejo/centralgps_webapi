defmodule CentralGPSWebAPI.Controllers.Client.Asset do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.Asset.Functions
  import CentralGPS.Repo.Utilities

  def asset_list(conn, params) do
    try do
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_monitor_asset_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def record_list(conn, params) do
    try do
      keys = [ :asset_id, :init_at, :stop_at ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:asset_id, nil, &(parse_int(&1)))
        |> Map.update(:init_at, nil, &(parse_datetime(&1)))
        |> Map.update(:stop_at, nil, &(parse_datetime(&1)))
        |> Map.values
        |> fn_api_asset_record_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def roadmap_list(conn, params) do
    try do
      keys = [ :asset_id, :roadmap_id, :init_at, :stop_at ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:asset_id, nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
        |> Map.update(:init_at, nil, &(parse_datetime(&1)))
        |> Map.update(:stop_at, nil, &(parse_datetime(&1)))
      {_, result} = fn_api_monitor_asset_roadmap_list((Map.drop(params, keys) |> Map.values) ++
        [ params.asset_id, params.roadmap_id, params.init_at, params.stop_at ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
