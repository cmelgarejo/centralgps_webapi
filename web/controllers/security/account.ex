defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Security.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def activate(conn, params) do
    try do
      _k = [ :account_id, :account_type, :set_active ]
      {headers, params} = proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> Map.values
        |> fn_api_account_active
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

  def create(conn, params) do
    try do
      _k = [ :account_type, :client_id, :user__login_name, :user__login_password, :user_dob, :user_identity_document, :user_info_emails, :user_info_phones, :user_language_template_id, :user_name, :user_profile_image, :user_timezone, :user_xtra_info ]
      {headers, params} = proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update  :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> Map.values
        |> fn_api_account_create
        {response_code, result} = (if result.ok, do: {201, result},
                                   else: {200, result |> Map.take [:ok, :msg]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      _k = [ :_auth_token, :_auth_type, :account_id, :account_type ]
      {headers, params} = proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> Map.values
        |> fn_api_account_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      _k = [ :_auth_token, :_auth_type, :account_id, :account_type, :user__login_password, :user_dob, :user_identity_document, :user_info_emails, :user_info_phones, :user_language_template_id, :user_name, :user_profile_image, :user_timezone, :user_xtra_info ]
      {headers, params} = proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> (Map.update  :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> Map.values
        |> fn_api_account_update
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      _k = [ :_auth_token, :_auth_type, :account_id, :account_type ]
      {headers, params} = proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> Map.values
        |> fn_api_account_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      {headers, params} = proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
        |> Map.values
        |> fn_api_account_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end
end
