defmodule CentralGPSWebAPI.Controllers.Device.Marks do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def register_mark(conn, params) do
    try do
      keys = [ :token, :form_id, :venue_id, :lat, :lon, :accuracy, :altitude,
        :notes, :address, :executed_at, :finished_at, :position_at]
      {headers, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      ip_header = :"x-forwarded-for"
      ip = if Map.has_key?(headers,ip_header), do: to_string(headers[ip_header]), else: nil
      {_, result} = params
        |>  Map.update(:executed_at,  nil, &(parse_datetime(&1)))
        |>  Map.update(:finished_at,  nil, &(parse_datetime(&1)))
        |>  Map.update(:position_at,  nil, &(parse_datetime(&1)))
        |>  Map.update(:lat,          nil, &(parse_float(&1)))
        |>  Map.update(:lon,          nil, &(parse_float(&1)))
        |>  Map.update(:accuracy,     nil, &(parse_datetime(&1)))
        |>  Map.update(:altitude,     nil, &(parse_datetime(&1)))
        |> (Map.put :_ip_port, ip)
        |> fn_chkapi_record
      response_code = if result.status, do: 201, else: 200
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
