defmodule CentralGPSWebAPI.Controllers.Client.RoadmapPoint do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.RoadmapPoint.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, _params) do
    try do
      _k = [ :roadmap_id, :name, :description, :lat, :lon, :point_order,
        :mean_arrival_time, :mean_leave_time, :detection_radius, :active, :xtra_info ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:lat,               nil, &(parse_float(&1)))
        |> Map.update(:lon,               nil, &(parse_float(&1)))
        |> Map.update(:point_order,       nil, &(parse_int(&1)))
        |> Map.update(:mean_arrival_time, nil, &(parse_time(&1)))
        |> Map.update(:mean_leave_time,   nil, &(parse_time(&1)))
        |> Map.update(:detection_radius,  nil, &(parse_int(&1)))
        |> Map.update(:active,            nil, &(parse_boolean(&1)))
        |> Map.update(:xtra_info, nil, &(&1))
      {row_count, result} = fn_api_roadmap_point_create((Map.drop(_params, _k) |> Map.values) ++
        [ _params.roadmap_id, _params.name, _params.description, _params.lat, _params.lon,
          _params.point_order, _params.mean_arrival_time, _params.mean_leave_time,
          _params.detection_radius, _params.active, _params.xtra_info ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, _params) do
    try do
      _k = [ :roadmap_id, :roadmap_point_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id,       nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_roadmap_point_read (Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_point_id, _params.roadmap_id ]
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :roadmap_point_id, :roadmap_id, :name, :description, :lat, :lon, :point_order,
        :mean_arrival_time, :mean_leave_time, :detection_radius, :active, :xtra_info ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_point_id,  nil, &(parse_int(&1)))
        |> Map.update(:roadmap_id,        nil, &(parse_int(&1)))
        |> Map.update(:lat,               nil, &(parse_float(&1)))
        |> Map.update(:lon,               nil, &(parse_float(&1)))
        |> Map.update(:point_order,       nil, &(parse_int(&1)))
        |> Map.update(:mean_arrival_time, nil, &(parse_time(&1)))
        |> Map.update(:mean_leave_time,   nil, &(parse_time(&1)))
        |> Map.update(:detection_radius,  nil, &(parse_int(&1)))
        |> Map.update(:active,            nil, &(parse_boolean(&1)))
        |> Map.update(:xtra_info, nil, &(&1))
        {row_count, result} = fn_api_roadmap_point_update((Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_point_id, _params.roadmap_id, _params.name, _params.description,
            _params.lat, _params.lon, _params.point_order, _params.mean_arrival_time, _params.mean_leave_time,
            _params.detection_radius, _params.active, _params.xtra_info ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :roadmap_id, :roadmap_point_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id,       nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_roadmap_point_delete (Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_point_id, _params.roadmap_id ]
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      _k = [ :roadmap_id ]
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
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
