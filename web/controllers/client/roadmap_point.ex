defmodule CentralGPSWebAPI.Controllers.Client.RoadmapPoint do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.RoadmapPoint.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :roadmap_id, :name, :notes, :description, :lat, :lon, :point_order,
        :mean_arrival_time, :mean_leave_time, :detection_radius, :active, :xtra_info,
        :venue_id, :form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:venue_id,          nil, &(parse_int(&1)))
        |> Map.update(:form_id,           nil, &(parse_int(&1)))
        |> Map.update(:lat,               nil, &(parse_float(&1)))
        |> Map.update(:lon,               nil, &(parse_float(&1)))
        |> Map.update(:point_order,       nil, &(parse_int(&1)))
        |> Map.update(:mean_arrival_time, nil, &(parse_time(&1)))
        |> Map.update(:mean_leave_time,   nil, &(parse_time(&1)))
        |> Map.update(:detection_radius,  nil, &(parse_int(&1)))
        |> Map.update(:active,            nil, &(parse_boolean(&1)))
        |> Map.update(:xtra_info,         nil, &(&1))
      {_, result} = fn_api_roadmap_point_create((Map.drop(params, keys) |> Map.values) ++
        [ params.roadmap_id, params.name, params.description, params.notes, params.lat, params.lon,
          params.point_order, params.mean_arrival_time, params.mean_leave_time,
          params.detection_radius, params.active, params.xtra_info, params.venue_id, params.form_id ])
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
      keys = [ :roadmap_id, :roadmap_point_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_id,       nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
      {_, result} =
        fn_api_roadmap_point_read (Map.drop(params, keys) |> Map.values) ++
          [ params.roadmap_point_id, params.roadmap_id ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :roadmap_point_id, :roadmap_id, :name, :description, :notes, :lat, :lon, :point_order,
        :mean_arrival_time, :mean_leave_time, :detection_radius, :active, :xtra_info,
        :venue_id, :form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_point_id,  nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:venue_id,          nil, &(parse_int(&1)))
        |> Map.update(:form_id,           nil, &(parse_int(&1)))
        |> Map.update(:lat,               nil, &(parse_float(&1)))
        |> Map.update(:lon,               nil, &(parse_float(&1)))
        |> Map.update(:point_order,       nil, &(parse_int(&1)))
        |> Map.update(:mean_arrival_time, nil, &(parse_time(&1)))
        |> Map.update(:mean_leave_time,   nil, &(parse_time(&1)))
        |> Map.update(:detection_radius,  nil, &(parse_int(&1)))
        |> Map.update(:active,            nil, &(parse_boolean(&1)))
        |> Map.update(:xtra_info,         nil, &(&1))
        {_, result} = fn_api_roadmap_point_update((Map.drop(params, keys) |> Map.values) ++
          [ params.roadmap_point_id, params.roadmap_id, params.name, params.description, params.notes,
            params.lat, params.lon, params.point_order, params.mean_arrival_time, params.mean_leave_time,
            params.detection_radius, params.active, params.xtra_info, params.venue_id, params.form_id ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update_point_order(conn, params) do
    try do
      keys = [ :roadmap_point_id, :roadmap_point_order ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_point_id,    nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_order, nil, &(parse_boolean(&1)))
        {_, result} = fn_api_roadmap_point_update_point_order((Map.drop(params, keys) |> Map.values) ++
          [ params.roadmap_point_id, params.roadmap_point_order ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :roadmap_id, :roadmap_point_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_id,       nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
      {_, result} =
        fn_api_roadmap_point_delete (Map.drop(params, keys) |> Map.values) ++
          [ params.roadmap_point_id, params.roadmap_id ]
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, params) do
    try do
      keys = [ :roadmap_id ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:roadmap_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_roadmap_point_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
