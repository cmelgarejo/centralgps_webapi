defmodule CentralGPSWebAPI.Controllers.Device.Record do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def record(conn, params) do
    try do
      _k = [ :accuracy, :form_id, :address, :altitude,
        :bearing, :comment, :lat, :lon, :mark, :position_at,
        :activity_id, :speed, :status, :xtra_info ]
      {_h, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      {_, result} = params
        |>  Map.update(:position_at,  nil, &(parse_datetime(&1)))
        |>  Map.update(:lat,          nil, &(parse_float(&1)))
        |>  Map.update(:lon,          nil, &(parse_float(&1)))
        |>  Map.update(:accuracy,     nil, &(parse_datetime(&1)))
        |>  Map.update(:altitude,     nil, &(parse_datetime(&1)))
        |> (Map.put :_ip_port, _ip)
        |> Map.values #|> Enum.concat([nil]) #add xtra_info
        |> fn_chkapi_record
      response_code = if result.status, do: 201, else: 200
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
