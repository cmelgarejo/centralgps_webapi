defmodule CentralGPSWebAPI.Controllers.Checkpoint.FormTemplate do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.FormTemplate.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, params) do
    try do
      keys = [ :form_id, :activity_id, :item_id, :measure_unit_id  ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:form_id,         nil, &(parse_int(&1)))
        |> Map.update(:activity_id,     nil, &(parse_int(&1)))
        |> Map.update(:item_id,         nil, &(parse_int(&1)))
        |> Map.update(:measure_unit_id, nil, &(parse_int(&1)))
      {_, result} = fn_api_form_template_create(Map.drop(params, keys) |> Map.values) ++
        [ params.form_id, params.activity_id, params.item_id, params.measure_unit_id]
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
      keys = [ :form_template_id ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:form_template_id, nil, &(parse_int(&1)))
        |> Map.values
        |> fn_api_form_template_read
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, params) do
    try do
      keys = [ :form_template_id, :form_id, :activity_id, :item_id, :measure_unit_id  ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:form_template_id, nil, &(parse_int(&1)))
        |> Map.update(:form_id,          nil, &(parse_int(&1)))
        |> Map.update(:activity_id,      nil, &(parse_int(&1)))
        |> Map.update(:item_id,          nil, &(parse_int(&1)))
        |> Map.update(:measure_unit_id,  nil, &(parse_int(&1)))
      {_, result} = fn_api_form_template_update((Map.drop(params, keys) |> Map.values) ++
        [ params.form_template_id, params.form_id, params.activity_id, params.item_id, params.measure_unit_id ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, params) do
    try do
      keys = [ :form_template_id, :remove_items ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = params
        |> Map.update(:form_template_id, nil,   &(parse_int(&1)))
        |> Map.update(:remove_items,     false, &(parse_boolean(&1)))
        |> Map.values
        |> fn_api_form_template_delete
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
        |> fn_api_form_template_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list_items(conn, params) do
    try do
      keys = [ :form_id, :activity_id ]
      {_, params} = list_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:form_id,          nil, &(parse_int(&1)))
        |> Map.update(:activity_id,      nil, &(parse_int(&1)))
      {_, result} = fn_api_form_template_list_items((Map.drop(params, keys) |> Map.values) ++
        [ params.form_id, params.activity_id ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
