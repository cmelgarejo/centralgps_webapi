defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Security.Functions
  import CentralGPS.Repo.Utilities
  

  def activate(conn, _params) do
    try do
      _k = [ :account_id, :account_type, :set_active ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :account_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :client_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :user_language_template_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :user_timezone, 0, fn(v)->(if !is_float(v), do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :status,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :account_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      _params = _params
        |> (Map.update :account_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :client_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :user_language_template_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :user_timezone, 0, fn(v)->(if !is_float(v), do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update  :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :status,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
      {row_count, result} = fn_api_account_read (Map.drop(_params, _k) |> Map.values) ++ [_params.account_id, _params.account_type] #get the record and check first
      if result.status do
        res = objectify_map result.res
        save_image_base64(_params.image, _params.image_file, res.profile_image)
        {row_count, result} = Map.values(_params) |> fn_api_account_update
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
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :account_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
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
      {headers, _params} = list_auth_proc_headers_and__params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_account_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
