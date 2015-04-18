defmodule CentralGPSWebAPI.Controllers.Security.Account do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Functions
  plug :action

  #todo: seguir con el registro de (client||entity)_account

  def register(conn, params) do
    try do
      _k = [ "_auth_token", "app_name", "ip_port", "type", "xtra_info",
      "user__login_name", "user__login_password", "user_dob",
      "user_info_emails", "user_info_phones", "user_language_template_id",
      "user_name", "user_profile_image", "user_timezone", "user_xtra_info",
       ]
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :user__login_name, fn(v)->(base64_decode v) end)
        |> (Map.update! :user__login_password,   fn(v)->(base64_decode v) end)
        #casting status to atom it will ensure the boolean conversion to pgsql
        |> Map.values
        |> fn_create_login_account
        result = hd(result) # the first result, if any.
        {response_code, result} = (if result.success, do: {201, result},
                          else: {200, result |> Map.take [:success, :message]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{error: e.message}
      e in Exception -> json (conn |> put_status 500), %{error: e.message}
    end
  end

end
