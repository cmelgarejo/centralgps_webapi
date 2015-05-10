defmodule CentralGPSWebAPI.Controllers.Security.Login do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Functions
  plug :action

  def login(conn, params) do
    try do
      _k = [ :_login_user, :_password, :auth_type, :session_status ]
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :_login_user, fn(v)->(base64_decode v) end)
        |> (Map.update! :_password,   fn(v)->(base64_decode v) end)
        |> (Map.update! :session_status,      fn(v)->(String.to_atom v) end) #casting session_status to atom will ensure boolean conversion in pgsql
        |> Map.values
        |> fn_api_login
        {response_code, result} = (if result.ok, do: {201, result},
                                   else: {200, result |> Map.take [:ok, :msg]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{ok: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{ok: false, msg: e.message}
    end
  end

end
