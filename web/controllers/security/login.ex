defmodule CentralGPSWebAPI.Controllers.Security.Login do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Account.Functions

  def login(conn, params) do
    try do
      keys = [ :_login_user, :_password, :auth_type, :session_status ]
      headers = Enum.into(conn.req_headers, %{}) |> objectify_map #Create a map of headers
      params = objectify_map(params)
      params = (if !Map.has_key?(params, :session_status),
                do: Map.put(params, :session_status, true),
              else: (if !is_boolean(params.session_status), do: Map.put(params, :session_status, false), else: params))
              |> objectify_map(keys)
      {_, result} = params
        |> Map.update(:_login_user,    nil,   fn(v)->(base64_decode v) end)
        |> Map.update(:_password,      nil,   fn(v)->(base64_decode v) end)
        |> Map.update(:session_status, false, fn(v)->(if !is_nil(v) && !is_boolean(v), do: false, else: v) end) #casting session_status to atom will ensure boolean conversion in pgsql
        |> (Map.put :the_app_name,
            (if Map.has_key?(headers,:"x-requested-with"),
              do: to_string(headers[:"x-requested-with"]),
              else: (if Map.has_key?(params, :the_app_name),
                      do: params._the_app_name, else: nil)))
        |> (Map.put :the_ip_port,
            (if Map.has_key?(headers,:"x-forwarded-for"),
              do: to_string(headers[:"x-forwarded-for"]),
              else: (if Map.has_key?(params, :the_ip_port),
                      do: params._the_ip_port, else: nil)))
        |> (Map.put :xtra_info, (if Map.has_key?(params, :xtra_info),
                                  do: params._xtra_info, else: nil))
        |> Map.values
        |> fn_api_login
        {response_code, result} = (if result.status, do: {201, result},
                                   else: {200, result |> Map.take([:status, :msg])})
        json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: "#{inspect e}"}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def logout(conn, params) do
    try do
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_logout
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

end
