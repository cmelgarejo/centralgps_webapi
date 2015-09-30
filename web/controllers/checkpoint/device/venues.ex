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
      _k = [ :_sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
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
      _k = [ :_sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
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
      _k = [ :_sync_token, :lat, :lon ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
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

  def venue_create(conn, _params) do
    try do
      _k = [ :configuration_id, :venue_type_id, :name, :code, :description, :image, :image_file,
        :lat, :lon, :detection_radius ]
      {_, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:configuration_id, nil,   &(parse_int(&1)))
        |> Map.update(:venue_type_id,    nil,   &(parse_int(&1)))
        |> Map.update(:detection_radius, nil,   &(parse_int(&1)))
        |> Map.update(:lat,              nil,   &(parse_float(&1)))
        |> Map.update(:lon,              nil,   &(parse_float(&1)))
      {_, result} = fn_chkapi_venue_create((Map.drop(_params, _k) |> Map.values) ++ [_params.configuration_id,
        _params.venue_type_id, _params.name, _params.code, _params.description,
        _params.image, _params.lat, _params.lon, _params.detection_radius,
        false])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      if (response_code == 201 && Map.has_key?(_params, :image_file)), do: save_image_base64(_params.image, _params.image_file)
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
