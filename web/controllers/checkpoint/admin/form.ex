defmodule CentralGPSWebAPI.Controllers.Checkpoint.Form do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Form.Functions
  import CentralGPS.Repo.Utilities


  def create(conn, params) do
    try do
      keys = [ :configuration_id, :description ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_form_create
        {response_code, result} = (if result.status, do: {201, result},
                                   else: {200, result |> Map.take([:status, :msg])})
        json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      keys = [ :form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:form_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_form_read
        json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :form_id, :configuration_id, :description ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:form_id, nil, &(parse_int(&1)))
      {_, result} = fn_api_form_update((Map.drop(params, keys) |> Map.values) ++
        [params.form_id, params.configuration_id, params.description])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:form_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_form_delete
        json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_form_list
        json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end
end
