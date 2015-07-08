defmodule CentralGPSWebAPI.Controllers.Security.Account.Role do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Functions


  def create(conn, _params) do
    try do
      _k = [ :account_id, :account_type, :role_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.update(:role_id,    nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_role_create
        {response_code, result} = (if result.status, do: {201, result},
                                else: {200, result |> Map.take [:status, :msg]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :account_id, :account_type, :role_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.update(:role_id,    nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_role_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
