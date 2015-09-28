defmodule CentralGPSWebAPI.Controllers.Device.Marks do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def mark(conn, params) do
    try do
      _k = [ :accuracy, :form_id, :address, :altitude,
        :bearing, :comment, :lat, :lon, :position_at,
        :activity_id, :speed, :status, :xtra_info ]
      {_h, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
      _ip_h = :"x-forwarded-for"
      _ip = if Map.has_key?(_h,_ip_h), do: to_string(_h[_ip_h]), else: nil
      {_, result} = params
        |> (Map.update :position_at, nil,
          &(if (elem Ecto.DateTime.cast(&1), 0) == :ok,
            do: elem(Ecto.DateTime.dump(elem(Ecto.DateTime.cast(&1),1)),1),
            else: nil))
        |> (Map.update :lat, 0, fn(v)->(if !is_float(v), do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :lon, 0, fn(v)->(if !is_float(v), do: elem(Float.parse(v), 0), else: v) end)
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
