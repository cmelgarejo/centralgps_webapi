defmodule CentralGPSWebAPI.Controllers.Checkpoint.Reason do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Reason.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def create(conn, _params) do
    try do
      _k = [ :configuration_id, :description ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      _params = _params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
      {row_count, result} = fn_api_reason_update((Map.drop(_params, _k) |> Map.values) ++ [_params.reason_id, _params.configuration_id, _params.description])
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :reason_id ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = list_auth_proc_headers_and__params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_reason_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
