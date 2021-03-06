defmodule CentralGPSWebAPI.Controllers.Device.Marks do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def register_mark(conn, params) do
    try do
      keys = [ :token, :form_id, :venue_id, :lat, :lon, :accuracy, :altitude,
      :notes, :address, :executed_at, :finished_at, :position_at ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:form_id,           nil, &(parse_int(&1)))
        |> Map.update(:venue_id,          nil, &(parse_int(&1)))
        |> Map.update(:client_contact_id, nil, &(parse_int(&1)))
        |> Map.update(:lat,               nil, &(parse_float(&1)))
        |> Map.update(:lon,               nil, &(parse_float(&1)))
        |> Map.update(:accuracy,          nil, &(parse_float(&1)))
        |> Map.update(:altitude,          nil, &(parse_float(&1)))
        |> Map.update(:executed_at,       nil, &(parse_datetime(&1)))
        |> Map.update(:finished_at,       nil, &(parse_datetime(&1)))
        |> Map.update(:position_at,       nil, &(parse_datetime(&1)))
      {_, result} = fn_chkapi_mark_create ([ params._auth_token,
        params.token, params.form_id, params.venue_id, params.lat, params.lon, params.accuracy,
        params.altitude, params.notes, params.address, params.client_contact_id,
        params.executed_at, params.finished_at, params.position_at])
      response_code = if result.status, do: 201, else: 200
      json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def register_mark_activity(conn, params) do
    try do
      keys = [ :id, :mark_token, :activity_id, :notes, :executed_at, :finished_at, :private, :pending, :event_at ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,           nil, &(parse_int(&1)))
        |> Map.update(:activity_id,  nil, &(parse_int(&1)))
        |> Map.update(:executed_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:finished_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:private,      nil, &(parse_boolean(&1)))
        |> Map.update(:pending,      nil, &(parse_boolean(&1)))
        |> Map.update(:event_at,     nil, &(parse_datetime(&1)))
        |> Map.update(:position_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:xtra_info,    nil, &(&1))
      {_, result} = fn_chkapi_mark_activity_create ([ params._auth_token, params.id,
        params.mark_token, params.activity_id, params.notes, params.executed_at,
        params.finished_at, params.private, params.pending, params.event_at, params.xtra_info ])
      response_code = if result.status, do: 201, else: 200
      json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def register_mark_activity_item(conn, params) do
    try do
      keys = [ :id, :mark_activity_id, :mark_token, :item_id, :measure_unit_id, :quantity, :xtra_info ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,               nil, &(parse_int(&1)))
        |> Map.update(:mark_activity_id, nil, &(parse_int(&1)))
        |> Map.update(:measure_unit_id,  nil, &(parse_int(&1)))
        |> Map.update(:item_id,          nil, &(parse_int(&1)))
        |> Map.update(:quantity,         nil, &(parse_float(&1)))
        |> Map.update(:xtra_info,        nil, &(&1))
      {_, result} = fn_chkapi_mark_activity_item_create ([ params._auth_token,
        params.id, params.mark_activity_id, params.mark_token, params.item_id,
        params.measure_unit_id, params.quantity, params.xtra_info ])
      response_code = if result.status, do: 201, else: 200
      json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def register_mark_activity_image(conn, params) do
    try do
      keys = [ :id, :mark_activity_id, :mark_token, :image_path, :image_bin, :image_created_at ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,               nil, &(parse_int(&1)))
        |> Map.update(:mark_activity_id, nil, &(parse_int(&1)))
        |> Map.update(:image_created_at, nil, &(parse_datetime(&1)))
        |> Map.update(:image_path,       nil, &(if (&1 != nil), do: "/images/checkpoint/mark/" <> params.mark_token <> "/activity/" <> to_string(params.mark_activity_id) <> "/" <> &1, else: nil))
        |> Map.update(:image_bin,        nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_chkapi_mark_activity_image_create ([ params._auth_token,
        params.id, params.mark_activity_id, params.mark_token, params.image_path,
        params.image_bin, params.image_created_at ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take([:status, :msg])})
      if (response_code == 201 && Map.has_key?(params, :image_bin)), do:
        save_image(params.image_path, params.image_bin)
      response_code = if result.status, do: 201, else: 200
      json((conn |> put_status(response_code)), result)
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end


  def update_mark(conn, params) do
    try do
      keys = [ :token, :notes, :client_contact_id, :finished_at ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:finished_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:client_contact_id, nil, &(parse_int(&1)))
      {_, result} = fn_chkapi_mark_update ([ params._auth_token, params.token,
        (if (params.client_contact_id == 0), do: nil, else: params.client_contact_id), params.notes, params.finished_at ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def update_mark_activity(conn, params) do
    try do
      keys = [ :id, :mark_token, :notes, :finished_at, :private, :pending, :event_at ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,           nil, &(parse_int(&1)))
        |> Map.update(:finished_at,  nil, &(parse_datetime(&1)))
        |> Map.update(:private,      nil, &(parse_boolean(&1)))
        |> Map.update(:pending,      nil, &(parse_boolean(&1)))
        |> Map.update(:event_at,     nil, &(parse_datetime(&1)))
        |> Map.update(:xtra_info,    nil, &(&1))
      {_, result} = fn_chkapi_mark_activity_update ([ params._auth_token, params.id,
        params.mark_token, params.notes, params.finished_at, params.private,
        params.pending, params.event_at, params.xtra_info])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def update_mark_activity_item(conn, params) do
    try do
      keys = [ :id, :mark_token, :item_id, :measure_unit_id, :quantity, :xtra_info]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,               nil, &(parse_int(&1)))
        |> Map.update(:measure_unit_id,  nil, &(parse_int(&1)))
        |> Map.update(:item_id,          nil, &(parse_int(&1)))
        |> Map.update(:quantity,         nil, &(parse_float(&1)))
        |> Map.update(:xtra_info,        nil, &(&1))
      {_, result} = fn_chkapi_mark_activity_item_update ([ params._auth_token,
        params.id, params.mark_token, params.item_id, params.measure_unit_id, params.quantity, params.xtra_info ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete_mark(conn, params) do
    try do
      keys = [ :token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {_, result} = fn_chkapi_mark_create ([ params._auth_token, params.token ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete_mark_activity(conn, params) do
    try do
      keys = [ :id, :mark_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,  nil, &(parse_int(&1)))
      {_, result} = fn_chkapi_mark_activity_delete ([ params._auth_token, params.id, params.mark_token ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete_mark_activity_item(conn, params) do
    try do
      keys = [ :id, :mark_activity_id, :mark_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,               nil, &(parse_int(&1)))
        |> Map.update(:mark_activity_id, nil, &(parse_int(&1)))
      {_, result} = fn_chkapi_mark_activity_item_delete ([ params._auth_token,
        params.id, params.mark_activity_id, params.mark_token ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

  def delete_mark_activity_image(conn, params) do
    try do
      keys = [ :id, :mark_activity_id, :mark_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:id,               nil, &(parse_int(&1)))
        |> Map.update(:mark_activity_id, nil, &(parse_int(&1)))
      {_, result} = fn_chkapi_mark_activity_image_delete ([ params._auth_token,
        params.id, params.mark_activity_id, params.mark_token ])
      json (conn |> put_status(200)), result
    rescue
      e in ArgumentError -> json (conn |> put_status(400)), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status(500)), %{status: false, msg: e.message}
    end
  end

end
