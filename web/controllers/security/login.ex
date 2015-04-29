defmodule CentralGPSWebAPI.Controllers.Security.Login do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Security.Functions
  plug :action

  #TODO: Check definition of the API fn in the DB.
  def login(conn, params) do
    try do
      _k = [ "_login_user", "_password", "app_name", "ip_port", "status",
             "type", "xtra_info" ]
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update! :_login_user, fn(v)->(base64_decode v) end)
        |> (Map.update! :_password,   fn(v)->(base64_decode v) end)
        |> (Map.update! :status,      fn(v)->(String.to_atom v) end)
        |> Map.values
        |> fn_login
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
