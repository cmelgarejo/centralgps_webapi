defmodule CentralGPSWebAPI.Controllers.Checkpoint.RoadmapPointVenueForm do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.RoadmapPointVenueForm.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :configuration_id, :form_id, :roadmap_point_id, :venue_id  ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:venue_id,         nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
        |> Map.update(:form_id,          nil, &(parse_int(&1)))
        |> Map.values
      {_, result} = fn_api_roadmap_point_venue_form_create((Map.drop(params, keys) |> Map.values) ++
        [ params.configuration_id, params.form_id, params.roadmap_point_id, params.venue_id ])
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
      keys = [ :roadmap_point_venue_form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:roadmap_point_venue_form_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_roadmap_point_venue_form_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :roadmap_point_venue_form_id, :configuration_id, :form_id, :roadmap_point_id, :venue_id  ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:roadmap_point_venue_form_id, nil, &(parse_int(&1)))
        |> Map.update(:configuration_id, nil, &(parse_int(&1)))
        |> Map.update(:venue_id,         nil, &(parse_int(&1)))
        |> Map.update(:roadmap_point_id, nil, &(parse_int(&1)))
        |> Map.update(:form_id,          nil, &(parse_int(&1)))
      {_, result} = fn_api_roadmap_point_venue_form_update((Map.drop(params, keys) |> Map.values) ++
        [ params.roadmap_point_venue_form_id, params.configuration_id, params.form_id, params.roadmap_point_id, params.venue_id ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :roadmap_point_venue_form_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:roadmap_point_venue_form_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_roadmap_point_venue_form_delete
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
        |> fn_api_roadmap_point_venue_form_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
