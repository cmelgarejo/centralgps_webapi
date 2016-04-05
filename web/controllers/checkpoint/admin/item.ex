defmodule CentralGPSWebAPI.Controllers.Checkpoint.Item do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Item.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :configuration_id, :name, :description, :notes, :stock, :min_qty, :max_qty, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:min_qty, nil, &(parse_float(&1)))
        |> Map.update(:max_qty, nil, &(parse_float(&1)))
      {_, result} = fn_api_item_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.name, params.description, params.notes,
          params.stock, params.min_qty, params.max_qty, params.xtra_info ])
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
      keys = [ :item_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:item_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_item_read
        json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :item_id, :configuration_id, :name, :description, :notes, :stock, :min_qty, :max_qty, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:item_id, nil, &(parse_int(&1)))
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:min_qty, nil, &(parse_float(&1)))
        |> Map.update(:max_qty, nil, &(parse_float(&1)))
      {_, result} = fn_api_item_read (Map.drop(params, keys) |> Map.values) ++
        [params.item_id] #get the record and check first
      if result.status do
        {_, result} = fn_api_item_update((Map.drop(params, keys) |> Map.values) ++ #drop the params first, and leave only the "head" parameters, auth_token, auth_type, app_name, ip, and notes of the caller
          [ params.item_id, params.configuration_id, params.name, params.description,
            params.notes, params.stock, params.min_qty, params.max_qty, params.xtra_info ])
      end
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :item_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:item_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_item_delete
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
        |> fn_api_item_list
        json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end
end
