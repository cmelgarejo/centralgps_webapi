defmodule CentralGPSWebAPI.Controllers.Checkpoint.ClientContact do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.ClientContact.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :client_id, :name, :notes, :emails, :phones, :notify ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:notify, nil, &(parse_boolean(&1)))
      {_, result} = fn_api_client_contact_create((Map.drop(params, keys) |> Map.values) ++
        [ params.client_id, params.name, params.notes, params.emails, params.phones, params.notify ])
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
      keys = [ :id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_client_contact_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :id, :client_id, :name, :notes, :emails, :phones, :notify ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id, nil, &(parse_int(&1)))
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:notify, nil, &(parse_boolean(&1)))
      {_, result} = fn_api_client_contact_read (Map.drop(params, keys) |> Map.values) ++
        [params.id] #get the record and check first
      if result.status do
        #res = objectify_map result.res
        {_, result} = fn_api_client_contact_update((Map.drop(params, keys) |> Map.values) ++ #drop the params first, and leave only the "head" parameters, auth_token, auth_type, app_name, ip, and xtra_info of the caller
          [ params.id, params.client_id, params.name, params.notes, params.emails, params.phones, params.notify ])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_client_contact_delete
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
        |> fn_api_client_contact_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
