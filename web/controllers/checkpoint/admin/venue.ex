defmodule CentralGPSWebAPI.Controllers.Checkpoint.Venue do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.Venue.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :configuration_id, :venue_type_id, :client_id, :active, :name, :code, :description,
        :address, :image_path, :image_bin, :lat, :lon, :detection_radius, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:venue_type_id,    nil, &(parse_int(&1)))
        |> Map.update(:client_id,        nil, &(parse_int(&1)))
        |> Map.update(:detection_radius, nil, &(parse_int(&1)))
        |> Map.update(:active,           nil, &(parse_boolean(&1)))
        |> Map.update(:lat,              nil, &(parse_float(&1)))
        |> Map.update(:lon,              nil, &(parse_float(&1)))
        |> Map.update(:image_bin,        nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_api_venue_create((Map.drop(params, keys) |> Map.values) ++
        [params.configuration_id, params.venue_type_id, params.client_id, params.name,
         params.code, params.description, params.address, params.image_path, params.image_bin,
         params.lat, params.lon, params.detection_radius, params.active, params.xtra_info])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      if (response_code == 201 && Map.has_key?(result, :image_bin)), do:
        save_image(params.image_path, params.image_bin)
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, params) do
    try do
      keys = [ :venue_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:venue_id, nil, &(parse_int(&1)))
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
      keys = [ :venue_id, :configuration_id, :venue_type_id, :client_id, :active, :name, :code, :description,
        :address, :image_path, :image_bin, :lat, :lon, :detection_radius, :xtra_info ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:venue_id,         nil, &(parse_int(&1)))
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:client_id,        nil, &(parse_int(&1)))
        |> Map.update(:venue_type_id,    nil, &(parse_int(&1)))
        |> Map.update(:detection_radius, nil, &(parse_int(&1)))
        |> Map.update(:active,           nil, &(parse_boolean(&1)))
        |> Map.update(:lat,              nil, &(parse_float(&1)))
        |> Map.update(:lon,              nil, &(parse_float(&1)))
        |> Map.update(:image_bin,        nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_api_venue_read (Map.drop(params, keys) |> Map.values) ++
        [params.venue_id] #get the record and check first
      if result.status do
        res = objectify_map result.res
        save_image(params.image_path, params.image_bin, res.venue_image)
        {_, result} = fn_api_venue_update((Map.drop(params, keys) |> Map.values) ++ #drop the params first, and leave only the "head" parameters, auth_token, auth_type, app_name, ip, and xtra_info of the caller
         [params.venue_id, params.configuration_id, params.venue_type_id, params.client_id,
          params.name, params.code, params.description, params.address,
          params.image_path, params.image_bin, params.lat, params.lon, params.detection_radius,
          params.active, params.xtra_info])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :venue_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:venue_id, nil, &(parse_int(&1)))
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
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params)
      {_, result} = params
        |> Map.values
        |> fn_api_venue_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
