defmodule CentralGPSWebAPI.Controllers.Checkpoint.VenueType do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.VenueType.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :configuration_id, :description, :image_path, :image_bin ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:activity_configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:image_bin,        nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_api_venue_type_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.description, params.image_path, params.image_bin])
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
      keys = [ :venue_type_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:venue_type_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_venue_type_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :venue_type_id, :configuration_id, :description, :image_path, :image_bin ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:venue_type_id,    nil, &(parse_int(&1)))
        |> Map.update(:image_bin,        nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_api_venue_type_read (Map.drop(params, keys) |> Map.values) ++
        [params.venue_type_id]
      if result.status do
        res = objectify_map result.res
        save_image(params.image_path, params.image_bin, res.image_path)
        {_, result} = fn_api_venue_type_update((Map.drop(params, keys) |> Map.values) ++
          [params.venue_type_id, params.configuration_id, params.description, params.image_path, params.image_bin])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :venue_type_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:venue_type_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_venue_type_delete
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
        |> fn_api_venue_type_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end


end
