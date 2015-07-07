defmodule CentralGPSWebAPI.Controllers.Client.Asset do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Client.Asset.Functions
  import CentralGPS.Repo.Utilities

  def asset_list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_monitor_asset_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def record_list(conn, _params) do
    try do
      _k = [ :asset_id, :init_at, :stop_at ]
      {headers, _params} = list_auth_proc_headers_and_params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> Map.update(:asset_id, 0, fn(v)->(if !is_nil(v) && !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.update(:init_at, nil,
          &(if (!is_nil(&1) && elem Ecto.DateTime.cast(&1), 0) == :ok,
            do: elem(Ecto.DateTime.dump(elem(Ecto.DateTime.cast(&1),1)),1),
            else: nil))
        |> Map.update(:stop_at, nil,
          &(if (!is_nil(&1) && elem Ecto.DateTime.cast(&1), 0) == :ok,
            do: elem(Ecto.DateTime.dump(elem(Ecto.DateTime.cast(&1),1)),1),
            else: nil))
        |> Map.values
        |> fn_api_asset_record_list
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end
end
