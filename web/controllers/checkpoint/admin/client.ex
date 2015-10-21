defmodule CentralGPSWebAPI.Controllers.Checkpoint.Client do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Client.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :configuration_id, :name, :description, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
      {_, result} = fn_api_client_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.name, params.description, params.xtra_info ])
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
      keys = [ :client_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_client_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :client_id, :configuration_id, :name, :description, :active, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
      {_, result} = fn_api_client_read (Map.drop(params, keys) |> Map.values) ++
        [params.client_id] #get the record and check first
      if result.status do
        #res = objectify_map result.res
        {_, result} = fn_api_client_update((Map.drop(params, keys) |> Map.values) ++ #drop the params first, and leave only the "head" parameters, auth_token, auth_type, app_name, ip, and xtra_info of the caller
         [params.client_id, params.configuration_id, params.name, params.description, params.active, params.xtra_info])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :client_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_client_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_client_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
