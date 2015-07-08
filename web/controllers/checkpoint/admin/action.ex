defmodule CentralGPSWebAPI.Controllers.Checkpoint.Action do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Action.Functions
  import CentralGPS.Repo.Utilities


  def create(conn, _params) do
    try do
      _k = [ :configuration_id, :description ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_action_create
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
      _k = [ :action_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:action_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_action_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :action_id, :configuration_id, :description ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:action_id, nil, &(parse_int(&1)))
      {row_count, result} = fn_api_action_update((Map.drop(_params, _k) |> Map.values) ++ [_params.action_id, _params.configuration_id, _params.description])
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :action_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:action_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_action_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_action_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
