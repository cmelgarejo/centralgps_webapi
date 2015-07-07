defmodule CentralGPSWebAPI.Controllers.Client.Roadmap do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.Roadmap.Functions
  import CentralGPS.Repo.Utilities

  def create(conn, _params) do
    try do
      _k = [ :name, :description, :days_of_week, :one_time_date, :repetition,
       :start_time, :end_time, :public, :active, :xtra_info ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:days_of_week, nil, &(if !is_nil(v) && is_list(&1), do: &1, else: nil))
        |> Map.update(:one_time_date, nil,
          &(if (!is_nil(&1) && elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> Map.update(:repetition, nil, &(if (!is_nil(&1) && !is_integer(&1)), do: elem(Integer.parse(&1), 0), else: nil))
        |> Map.update(:start_time, nil,
          &(if (!is_nil(&1) && elem Ecto.Time.cast(&1), 0) == :ok,
            do: elem(Ecto.Time.dump(elem(Ecto.Time.cast(&1),1)),1),
            else: nil))
        |> Map.update(:end_time, nil,
          &(if (!is_nil(&1) && elem Ecto.Time.cast(&1), 0) == :ok,
            do: elem(Ecto.Time.dump(elem(Ecto.Time.cast(&1),1)),1),
            else: nil))
        |> Map.update(:public, nil, &(if !is_nil(&1) && is_boolean(&1), do: &1, else: nil))
        |> Map.update(:active, nil, &(if !is_nil(&1) && is_boolean(&1), do: &1, else: nil))
        |> Map.update(:xtra_info, nil, &(&1))
      {row_count, result} = fn_api_roadmap_create((Map.drop(_params, _k) |> Map.values) ++
        [ _params.name, _params.description, _params.days_of_week, _params.repetition,
          _params.one_time_date, _params.start_time, _params.end_time, _params.public,
          _params.active, _params.xtra_info ])
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
      _k = [ :roadmap_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:roadmap_id, 0, fn(v)->(if !is_nil(v) && !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_roadmap_read
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :roadmap_id, :name, :description, :days_of_week, :one_time_date, :repetition,
        :start_time, :end_time, :public, :active, :xtra_info ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      _params = _params
        |> Map.update(:roadmap_id, nil, fn(v)->(if !is_nil(v) && !is_integer(v), do: elem(Integer.parse(v), 0), else: nil) end)
        |> Map.update(:days_of_week, nil, &(if !is_nil(v) && is_list(&1), do: &1, else: nil))
        |> Map.update(:one_time_date, nil,
          &(if (!is_nil(&1) && elem Ecto.Date.cast(&1), 0) == :ok,
            do: elem(Ecto.Date.dump(elem(Ecto.Date.cast(&1),1)),1),
            else: nil))
        |> Map.update(:repetition, nil, &(if (!is_nil(&1) && !is_integer(&1)), do: elem(Integer.parse(&1), 0), else: nil))
        |> Map.update(:start_time, nil,
          &(if (!is_nil(&1) && elem Ecto.Time.cast(&1), 0) == :ok,
            do: elem(Ecto.Time.dump(elem(Ecto.Time.cast(&1),1)),1),
            else: nil))
        |> Map.update(:end_time, nil,
          &(if (!is_nil(&1) && elem Ecto.Time.cast(&1), 0) == :ok,
            do: elem(Ecto.Time.dump(elem(Ecto.Time.cast(&1),1)),1),
            else: nil))
        |> Map.update(:public, nil, &(if !is_nil(&1) && is_boolean(&1), do: &1, else: nil))
        |> Map.update(:active, nil, &(if !is_nil(&1) && is_boolean(&1), do: &1, else: nil))
        |> Map.update(:xtra_info, nil, &(&1))
        {row_count, result} = fn_api_roadmap_create((Map.drop(_params, _k) |> Map.values) ++
          [ _params.roadmap_id, _params.name, _params.description, _params.days_of_week,
            _params.repetition, _params.one_time_date, _params.start_time, _params.end_time,
            _params.public, _params.active, _params.xtra_info ])
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :roadmap_id ]
      {headers, _params} = auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:roadmap_id, 0, fn(v)->(if !is_nil(v) && !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_roadmap_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_roadmap_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
