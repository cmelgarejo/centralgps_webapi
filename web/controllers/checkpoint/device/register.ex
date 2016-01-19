defmodule CentralGPSWebAPI.Controllers.Device.Register do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def register(conn, params) do
    try do
      keys =  [ :_login_user, :_password, :imei, :msisdn, :uuid, :xtra_info ]
      headers = objectify_map Enum.into(conn.req_headers, %{})
      ip_header = :"x-forwarded-for"
      ip = if Map.has_key?(headers, ip_header), do: to_string(headers[ip_header]), else: nil
      params = objectify_map(params)
      {_, result} = objectify_map(params, keys)
        |> (Map.update :_login_user, nil, fn(v)->(base64_decode v) end)
        |> (Map.update :_password,   nil, fn(v)->(base64_decode v) end)
        |> Map.values
        |> Enum.concat([ (ip), ("centralgps_webapi"), %{ register: true, request_headers: headers } ])
        |> fn_chkapi_device_register
        {response_code, result} = (if result.status, do: {201, result},
                          else: {200, result |> Map.take([:status, :msg])})
        json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

end
