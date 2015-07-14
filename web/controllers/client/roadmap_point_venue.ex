defmodule CentralGPSWebAPI.Controllers.Checkpoint.RoadmapPointVenue do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.RoadmapPointVenue.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, _params) do
    try do
      _k = [ :roadmap_point_id, :venue_id, :action_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_point_id,  nil, &(parse_int(&1)))
        |> Map.update(:venue_id,          nil, &(parse_int(&1)))
        |> Map.update(:action_id,         nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_roadmap_point_venue_create (Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_point_id, _params.venue_id, _params.action_id ]
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :roadmap_point_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_point_id,  nil, &(parse_int(&1)))
        # |> Map.update(:venue_id,          nil, &(parse_int(&1)))
        # |> Map.update(:action_id,         nil, &(parse_int(&1)))
      {row_count, result} =
        fn_api_roadmap_point_venue_delete (Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_point_id ] #, _params.venue_id, _params.action_id ]
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
