defmodule CentralGPSWebAPI.Controllers.Device.Register do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def register(conn, params) do
    try do
      _k =  [ :_login_user, :_password, :imei, :msisdn, :uuid, :xtra_info ]
      _h = objectify_map Enum.into(conn.req_headers, %{})
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      params = objectify_map(params)
      {row_count, result} = objectify_map(params, _k)
        |> (Map.update :_login_user, nil, fn(v)->(base64_decode v) end)
        |> (Map.update :_password,   nil, fn(v)->(base64_decode v) end)
        |> Map.values
        |> Enum.concat([ (_ip), (Atom.to_string :checkpoint_api),
              %{ register: true, request_headers: _h } ])
        |> fn_chkapi_device_register
        {response_code, result} = (if result.status, do: {201, result},
                          else: {200, result |> Map.take [:status, :msg]})
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
