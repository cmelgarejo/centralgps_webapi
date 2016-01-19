defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Security.Account.Functions
  import CentralGPS.Repo.Utilities

  def activate(conn, params) do
    try do
      keys = [ :account_id, :account_type, :set_active ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:account_id, nil, &(parse_int(&1)))
        |> Map.values
        |> (fn_api_account_active)
      json((conn |> put_status(200)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
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
      if (Map.has_key?(params, :image_bin) && params.image_bin != nil), do:
        save_image(params.image_path, params.image_bin)
      {_, result} = fn_api_account_create((Map.drop(params, keys) |> Map.values) ++
        [ params.account_type, params.client_id, params.login_name, params.login_password,
          params.dob, params.identity_document, params.info_emails, params.info_phones,
          params.language_template_id, params.name, params.image_path, params.image_bin,
          params.timezone, params.xtra_info ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take([:status, :msg])})
      if (response_code == 201 && Map.has_key?(params, :image_bin)), do:
        save_image(params.image_path, params.image_bin)
      json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
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
        json((conn |> put_status(200)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
    end
  end

  def update(conn, params) do
    try do
      keys = [ :account_id, :account_type, :login_password, :dob, :identity_document,
        :info_emails, :info_phones, :language_template_id, :name, :image_path, :image_bin,
        :timezone, :xtra_info]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:account_id,           nil, &(parse_int(&1)))
        |> Map.update(:login_password,       nil, &(if (&1 == "" || &1 == " "), do: nil, else: &1))
        |> Map.update(:language_template_id, nil, &(parse_int(&1)))
        |> Map.update(:timezone,             nil, &(parse_float(&1)))
        |> Map.update(:dob,                  nil, &(parse_datetime(&1)))
        |> Map.update(:image_bin,            nil, &(if (&1 == nil), do: nil, else: Base.url_decode64!(&1)))
      {_, result} = fn_api_account_read((Map.drop(params, keys) |> Map.values) ++
        [ params.account_id, params.account_type ])#get the record and check first
      if result.status do
        res = objectify_map result.res
        if (Map.has_key?(params, :image_bin) && params.image_bin != nil), do:
          save_image(params.image_path, params.image_bin, res.image_path)
        {_, result} = fn_api_account_update((Map.drop(params, keys) |> Map.values) ++
          [ params.account_id, params.account_type, params.login_password, params.dob,
           params.identity_document, params.info_emails, params.info_phones,
           params.language_template_id, params.name, params.image_path, params.image_bin,
           params.timezone, params.xtra_info ])
      end
      json((conn |> put_status(200)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
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
        json((conn |> put_status(200)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
    end
  end

  def list(conn, params) do
    try do
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_account_list
        json((conn |> put_status(200)), result)
    rescue
      e in ArgumentError -> json((conn |> put_status(400)), %{status: false, msg: e.message})
      e in Exception -> json((conn |> put_status(500)), %{status: false, msg: e.message})
    end
  end
end
