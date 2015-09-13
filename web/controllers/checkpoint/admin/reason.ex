defmodule CentralGPSWebAPI.Controllers.Checkpoint.Reason do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Reason.Functions
  import CentralGPS.Repo.Utilities
  

  def create(conn, _params) do
    try do
      _k = [ :configuration_id, :description ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_reason_create
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
      _k = [ :reason_id ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:reason_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_reason_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :configuration_id, :description, :reason_id ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:reason_id, nil, &(parse_int(&1)))
      {_, result} = fn_api_reason_update((Map.drop(_params, _k) |> Map.values) ++ [_params.reason_id, _params.configuration_id, _params.description])
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :reason_id ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:reason_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_reason_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      {_, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params)
      {_, result} = _params
        |> Map.values
        |> fn_api_reason_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
