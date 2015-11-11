defmodule CentralGPSWebAPI.Controllers.Client.AssetRoadmap do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.AssetRoadmap.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :asset_id, :roadmap_id, :emails, :phones, :alert ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:asset_id,          nil, &(parse_int(&1)))
        |> Map.update(:alert,             nil, &(parse_boolean(&1)))
      {_, result} = fn_api_asset_roadmap_create((Map.drop(params, keys) |> Map.values) ++
        [ params.asset_id, params.roadmap_id, params.emails, params.phones, params.alert ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      keys = [ :asset_id, :roadmap_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:asset_id,   nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
      {_, result} =
        fn_api_asset_roadmap_read (Map.drop(params, keys) |> Map.values) ++
          [ params.asset_id, params.roadmap_id ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :asset_id, :roadmap_id, :emails, :phones, :alert ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:asset_id,          nil, &(parse_int(&1)))
        |> Map.update(:alert,             nil, &(parse_boolean(&1)))
      {_, result} = fn_api_asset_roadmap_update((Map.drop(params, keys) |> Map.values) ++
        [ params.asset_id, params.roadmap_id, params.emails, params.phones, params.alert ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :asset_id, :roadmap_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:asset_id,   nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
      {_, result} =
        fn_api_asset_roadmap_delete (Map.drop(params, keys) |> Map.values) ++
          [ params.asset_id, params.roadmap_id ]
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def roadmap_list(conn, params) do
    try do
      keys = [ :asset_id ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} =
        fn_api_asset_roadmap_list (Map.drop(params, keys) |> Map.values) ++
          [ parse_int(params.asset_id), nil ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def asset_list(conn, params) do
    try do
      keys = [ :roadmap_id ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} =
        fn_api_asset_roadmap_list (Map.drop(params, keys) |> Map.values) ++
          [ nil, parse_int(params.roadmap_id) ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def all_list(conn, params) do
    try do
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_asset_roadmap_all_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
