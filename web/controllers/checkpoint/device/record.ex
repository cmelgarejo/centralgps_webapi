defmodule CentralGPSWebAPI.Controllers.Device.Record do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def record(conn, params) do
    try do
      keys = [ :lat, :lon, :speed, :bearing, :accuracy, :altitude, :status, :address, :position_at ]
      {headers, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      ip_header = :"x-forwarded-for"
      ip = if Map.has_key?(headers,ip_header), do: to_string(headers[ip_header]), else: nil
      params = params
        |>  Map.update(:accuracy,     nil, &(parse_float(&1)))
        |>  Map.update(:altitude,     nil, &(parse_float(&1)))
        |>  Map.update(:lat,          nil, &((&1)))
        |>  Map.update(:lon,          nil, &(parse_float(&1)))
        |>  Map.update(:position_at,  nil, &(parse_datetime(&1)))
        |> (Map.put :ip_port, ip)
      {_, result} = fn_chkapi_record ([ params.lat, params.lon, params.speed,
        params.bearing, params.accuracy, params.altitude, params.status,
        params.address, params.ip_port, params.position_at])
      response_code = if result.status, do: 201, else: 200
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
