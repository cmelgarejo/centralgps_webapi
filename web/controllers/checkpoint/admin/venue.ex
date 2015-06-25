defmodule CentralGPSWebAPI.Controllers.Checkpoint.Venue do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Venue.Functions
  import CentralGPS.Repo.Utilities
  

  def create(conn, _params) do
    try do
      _k = [ :configuration_id, :venue_type_id, :name, :code, :description, :image,
        :lat, :lon, :detection_radius, :xtra_info ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      _params = _params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :venue_type_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :detection_radius, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :lat,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :lon,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
      {row_count, result} = fn_api_venue_create((Map.drop(_params, _k) |> Map.values) ++ [_params.configuration_id,
        _params.venue_type_id, _params.name, _params.code, _params.description,
        _params.image, _params.lat, _params.lon, _params.detection_radius,
        _params.xtra_info])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      if (response_code == 201 && Map.has_key?(result, :image_file)), do: save_image_base64(_params.image, _params.image_file)
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, _params) do
    try do
      _k = [ :venue_id ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :venue_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :venue_id, :configuration_id, :venue_type_id, :name, :code, :description, :image,
        :lat, :lon, :detection_radius, :xtra_info, :image_file ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      _params = _params
        |> (Map.update :venue_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :venue_type_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :detection_radius, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :lat,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :lon,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
      {row_count, result} = fn_api_venue_read (Map.drop(_params, _k) |> Map.values) ++ [_params.venue_id] #get the record and check first
      if result.status do
        res = objectify_map result.res
        save_image_base64(_params.image, _params.image_file, res.venue_image)
        {row_count, result} = fn_api_venue_update((Map.drop(_params, _k) |> Map.values) ++ #drop the params first, and leave only the "head" parameters, auth_token, auth_type, app_name, ip, and xtra_info of the caller
         [_params.venue_id, _params.configuration_id,
          _params.venue_type_id, _params.name, _params.code, _params.description,
          _params.image, _params.lat, _params.lon, _params.detection_radius,
          _params.xtra_info])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :venue_id ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :venue_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and__params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_venue_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
