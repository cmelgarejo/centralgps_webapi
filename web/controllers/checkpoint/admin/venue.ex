defmodule CentralGPSWebAPI.Controllers.Checkpoint.Venue do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Venue.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def create(conn, params) do
    try do
      _k = [ :configuration_id, :venue_type_id, :code, :description, :name,
             :venue_image, :lat, :lon, :detection_radius, :xtra_info ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      params = params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :venue_type_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :detection_radius, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :lat,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :lon,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
      #special case, when the parameters cannot be naturally ordered, lets use
      # the objectified-sugared map to throw the parameters to the function
      # in the right order
      {row_count, result} = fn_api_venue_create([params.configuration_id,
        params.venue_type_id, params.code, params.description, params.name,
        params.venue_image, params.lat, params.lon, params.detection_radius,
        params.xtra_info])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      _k = [ :venue_id ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update :venue_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      _k = [ :venue_type_id, :code, :description, :name, :venue_image,
             :lat, :lon, :detection_radius, :xtra_info ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      params = params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :venue_type_id,    0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :detection_radius, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :lat,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
        |> (Map.update :lon,              0, fn(v)->(if !is_float(v),   do: elem(Float.parse(v), 0), else: v) end)
      #special case, when the parameters cannot be naturally ordered, lets use
      # the objectified-sugared map to throw the parameters to the function
      # in the right order
      {row_count, result} = fn_api_venue_create([params.venue_type_id,
        params.code, params.description, params.name, params.venue_image,
        params.lat, params.lon, params.detection_radius, params.xtra_info])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      _k = [ :venue_id ]
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
        |> (Map.update :venue_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      {headers, params} = auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
        |> Map.values
        |> fn_api_venue_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
