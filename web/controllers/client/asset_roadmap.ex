defmodule CentralGPSWebAPI.Controllers.Client.AssetRoadmap do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.AssetRoadmap.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, _params) do
    try do
      _k = [ :asset_id, :roadmap_id, :emails, :phones, :alert ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:asset_id,          nil, &(parse_float(&1)))
        |> Map.update(:alert,             nil, &(parse_boolean(&1)))
      {row_count, result} = fn_api_asset_roadmap_create((Map.drop(_params, _k) |> Map.values) ++
        [ _params.asset_id, _params.roadmap_id, _params.emails, _params.phones, _params.alert ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, _params) do
    try do
      _k = [ :asset_id, :roadmap_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:asset_id,   nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_asset_roadmap_read (Map.drop(_params, _k) |> Map.values) ++
          [ _params.asset_id, _params.roadmap_id ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :asset_id, :roadmap_id, :emails, :phones, :alert ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:asset_id,          nil, &(parse_float(&1)))
        |> Map.update(:alert,             nil, &(parse_boolean(&1)))
      {row_count, result} = fn_api_asset_roadmap_update((Map.drop(_params, _k) |> Map.values) ++
        [ _params.asset_id, _params.roadmap_id, _params.emails, _params.phones, _params.alert ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :asset_id, :roadmap_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:asset_id,   nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_asset_roadmap_delete (Map.drop(_params, _k) |> Map.values) ++
          [ _params.asset_id, _params.roadmap_id ]
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      _k = [ :asset_id ]
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} =
        fn_api_asset_roadmap_list (Map.drop(_params, _k) |> Map.values) ++
          [ _params.asset_id ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def all_list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_asset_roadmap_all_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
