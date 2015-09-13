defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Security.Functions
  import CentralGPS.Repo.Utilities

  def activate(conn, _params) do
    try do
      _k = [ :account_id, :account_type, :set_active ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_active
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def create(conn, _params) do
    try do
      _k = [ :account_type, :client_id, :user__login_name, :user__login_password, :user_dob, :user_identity_document, :user_info_emails, :user_info_phones, :user_language_template_id, :user_name, :user_profile_image, :user_timezone, :user_xtra_info ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:user_language_template_id,    nil, &(parse_int(&1)))
        |> Map.update(:user_timezone, nil, &(parse_float(&1)))
        |> Map.update(:user_dob, nil, &(parse_datetime(&1)))
        |> Map.values
        |> fn_api_account_create
        {response_code, result} = (if result.status, do: {201, result},
                                   else: {200, result |> Map.take [:status, :msg]})
        if (response_code == 201 && Map.has_key?(result, :image_file)), do: save_image_base64(_params.user_profile_image, _params.image_file)
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, _params) do
    try do
      _k = [ :account_id, :account_type ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :account_id, :account_type, :user__login_password, :user_dob, :user_identity_document, :user_info_emails, :user_info_phones, :user_language_template_id, :user_name, :user_profile_image, :user_timezone, :user_xtra_info , :image_file ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:user_language_template_id,    nil, &(parse_int(&1)))
        |> Map.update(:user_timezone, nil, &(parse_float(&1)))
        |> Map.update( :user_dob, nil, &(parse_datetime(&1)))
      {_, result} = fn_api_account_read (Map.drop(_params, _k) |> Map.values) ++ [_params.account_id, _params.account_type] #get the record and check first
      if result.status do
        res = objectify_map result.res
        save_image_base64(_params.image, _params.image_file, res.profile_image)
        {_, result} = Map.values(_params) |> fn_api_account_update
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :account_id, :account_type ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {_, result} = _params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_delete
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
        |> fn_api_account_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
