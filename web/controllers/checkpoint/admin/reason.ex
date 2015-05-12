defmodule CentralGPSWebAPI.Controllers.Checkpoint.Reason do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Reason.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def create(conn, params) do
    try do
      _k = [ :configuration_id, :description ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
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

  def read(conn, params) do
    try do
      _k = [ :reason_id ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_reason_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      _k = [ :reason_id, :description ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_reason_update
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      _k = [ :reason_id ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update :reason_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_reason_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
        |> Map.values
        |> fn_api_reason_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
