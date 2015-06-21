defmodule CentralGPSWebAPI.Controllers.Checkpoint.VenueType do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Checkpoint.VenueType.Functions
  import CentralGPS.Repo.Utilities
  plug :action

  def create(conn, _params) do
    try do
      _k = [ :configuration_id, :description, :image, :image_file ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :reason_configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_type_create
        {response_code, result} = (if result.status, do: {201, result},
                                   else: {200, result |> Map.take [:status, :msg]})
        if (response_code == 201 && Map.has_key? :image_file ), do: save_image(_params.image, _params.image_file)
        json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def read(conn, _params) do
    try do
      _k = [ :venue_type_id ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :venue_type_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_type_read
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def update(conn, _params) do
    try do
      _k = [ :venue_type_id, :configuration_id, :description, :image, :image_file ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      _params = _params
        |> (Map.update :configuration_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> (Map.update :venue_type_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
      {row_count, result} = fn_api_venue_type_read (Map.drop(_params, _k) |> Map.values) ++ [_params.venue_type_id]
      if result.status do
        res = objectify_map result.res
        save_image(_params.image, _params.image_file, res.venue_type_image)
        {row_count, result} = fn_api_venue_type_update((Map.drop(_params, _k) |> Map.values) ++ [_params.venue_type_id, _params.configuration_id,
          _params.description, _params.image])
      end
      json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def delete(conn, _params) do
    try do
      _k = [ :venue_type_id ]
      {headers, _params} = auth_proc_headers_and__params(conn.req_headers, _params, _k)
      {row_count, result} = _params
        |> (Map.update :venue_type_id, 0, fn(v)->(if !is_integer(v), do: elem(Integer.parse(v), 0), else: v) end)
        |> Map.values
        |> fn_api_venue_type_delete
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def list(conn, _params) do
    try do
      {headers, _params} = list_auth_proc_headers_and__params(conn.req_headers, _params)
      {row_count, result} = _params
        |> Map.values
        |> fn_api_venue_type_list
        json (conn |> put_status 200), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  defp _local_image_path, do: Enum.join([Endpoint.config(:root), "priv/static"], "/")
  defp dest_dir(filename), do: String.split(filename, "/") |> Enum.reverse |> tl |> Enum.reverse |> Enum.join
  defp save_image(filename, file, old_filename \\ "") do
    try do
      if !is_nil(filename) do
        IO.puts "filename: #{inspect filename}"
        IO.puts "old_filename: #{inspect old_filename}"
        if (old_filename != ""), do: File.rm Enum.join([ _local_image_path,  old_filename ], "/") #removes the old image
        IO.puts "dest_dir(filename): #{inspect dest_dir(filename)}"
        if (File.exists?dest_dir(filename)), do: File.mkdir_p dest_dir(filename)
        IO.puts "updated |> filename: #{inspect filename}"
        filename = Enum.join [ _local_image_path, dest_dir(filename), filename ], "/"
        File.write!filename, base64_decode(file)
      end
    rescue
      e in _ -> IO.puts "#{inspect e}"
      :error
    end
    :ok
  end

end
