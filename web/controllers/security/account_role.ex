defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Functions
  plug :action

  def account_activate(conn, params) do
    try do
      _k = [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type", "set_active" ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> (Map.put :_xtra_info, nil)
        |> Map.values
        |> fn_api_account_active
        result = hd(result) # the first result, if any.
        #{response_code, result} = (if result.success, do: {200, result}, else: {404, result})
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

  def account_create(conn, params) do
    try do
      _k = [ "_auth_token", "_my_account_type", "account_type", "client_id", "user__login_name", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update  :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> (Map.put :_xtra_info, nil)
        |> Map.values
        |> fn_api_account_create
        result = hd(result) # the first result, if any.
        {response_code, result} = (if result.success, do: {201, result},
                          else: {200, result |> Map.take [:success, :message]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

  def account_read(conn, params) do
    try do
      _k = ["_auth_token", "_my_account_type", "account_id", "account_type"]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> (Map.put :_xtra_info, nil)
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> Map.values
        |> fn_api_account_read
        result = hd(result) # the first result, if any.
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

  def account_update(conn, params) do
    try do
      _k = [ "_auth_token", "_my_account_type", "account_id", "account_type", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> (Map.update  :user_dob, nil,
          &(if (elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> (Map.put :_xtra_info, nil)
        |> Map.values
        |> fn_api_account_update
        result = hd(result) # the first result, if any.
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

  def account_delete(conn, params) do
    try do
      _k = [ "_auth_token", "_my_account_type", "account_id", "account_type" ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :account_id, fn(v)->(Integer.parse(v) |> elem 0) end)
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> (Map.put :_xtra_info, nil)
        |> Map.values
        |> fn_api_account_delete
        result = hd(result) # the first result, if any.
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

  def account_list(conn, params) do
    try do
      _k = [ "_auth_token", "_my_account_type" ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      _app_h = :"x-app-name"
      _app = if Map.has_key?(_h,_app_h), do: to_string(_h[_app_h]), else: nil
      {row_count, result} = objectify_map(params, _k)
        |> (Map.put :_the_app_name, _app)
        |> (Map.put :_the_ip_port, _ip)
        |> Map.values
        |> Enum.concat([nil]) #|> Enum.concat(Map.to_list(_h)) #add xtra_info
        |> fn_api_account_list
        #result = hd(result) # the first result, if any.
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{success: false, message: e.message}
      e in Exception -> json (conn |> put_status 500), %{success: false, message: e.message}
    end
  end

end
