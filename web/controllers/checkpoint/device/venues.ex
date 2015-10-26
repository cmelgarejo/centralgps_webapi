defmodule CentralGPSWebAPI.Controllers.Device.Venues do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def venue_types(conn, params) do
    try do
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
      |> Map.values #trim just the value we want from the request (auth_token)
      |> Enum.concat([ nil, "A"]) #The form to sync is ALL, and no sync_token
      |> fn_chkapi_venue_type_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def venue_types_update(conn, params) do
    try do
      keys = [ :sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {row_count, result} = params
      |> Map.values #get: auth and sync tokens
      |> Enum.concat(["U"]) #and UPDATE form
      |> fn_chkapi_venue_type_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def venues(conn, params) do
    try do
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
      |> Map.values #trim just the value we want from the request (auth_token)
      |> Enum.concat([ nil, "A"]) #The form to sync is ALL, and no sync_token
      |> fn_chkapi_venue_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def venues_update(conn, params) do
    try do
      keys = [ :sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {row_count, result} = params
      |> Map.values #get: auth and sync tokens
      |> Enum.concat(["U"]) #and UPDATE form
      |> fn_chkapi_venue_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def venues_near(conn, params) do
    try do
      keys = [ :sync_token, :lat, :lon ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {row_count, result} = params
      |> (Map.update :lat, Decimal.new(0), fn(v)->(Decimal.new v) end) #decimal
      |> (Map.update :lon, Decimal.new(0), fn(v)->(Decimal.new v) end) #decimal
      |> Map.values #trim just the value we want from the request (auth_token)
      |> fn_chkapi_near_venue_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

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
      {_, result} = fn_chkapi_venue_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.venue_type_id, params.client_id, params.name,
          params.code, params.description, params.address, params.image_path, params.image_bin,
          params.lat, params.lon, params.detection_radius, params.active, params.xtra_info ])
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

end
