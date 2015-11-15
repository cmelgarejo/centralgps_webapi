defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Security.Functions
  import CentralGPS.Repo.Utilities

  def activate(conn, params) do
    try do
      keys = [ :account_id, :account_type, :set_active ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_active
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def create(conn, params) do
    try do
      keys = [ :account_type, :client_id, :login_name, :login_password, :dob, :identity_document,
      :info_emails, :info_phones, :language_template_id, :name, :image_path, :image_bin,
      :timezone, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:client_id,            nil, &(parse_int(&1)))
        |> Map.update(:language_template_id, nil, &(parse_int(&1)))
        |> Map.update(:timezone,             nil, &(parse_float(&1)))
        |> Map.update(:dob,                  nil, &(parse_date(&1)))
        |> Map.update(:image_bin,            nil, &(Base.url_decode64!(&1)))
      {_, result} = fn_api_account_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.description, params.image_path, params.image_bin])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      if (response_code == 201 && Map.has_key?(params, :image_bin)), do:
        save_image(params.image_path, params.image_bin)
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      keys = [ :account_id, :account_type ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :account_id, :account_type, :_login_password, :dob, :identity_document, :info_emails, :info_phones, :language_template_id, :name, :profile_image, :timezone, :xtra_info , :image_file ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:account_id,           nil, &(parse_int(&1)))
        |> Map.update(:client_id,            nil, &(parse_int(&1)))
        |> Map.update(:language_template_id, nil, &(parse_int(&1)))
        |> Map.update(:timezone,             nil, &(parse_float(&1)))
        |> Map.update(:dob,                  nil, &(parse_datetime(&1)))
      {_, result} = fn_api_account_read (Map.drop(params, keys) |> Map.values) ++
        [params.account_id, params.account_type] #get the record and check first
      if result.status do
        res = objectify_map result.res
        save_image(params.image_path, params.image_bin, res.image_path)
        {_, result} = Map.values(params) |> fn_api_account_update
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :account_id, :account_type ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_account_delete
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
        |> fn_api_account_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
