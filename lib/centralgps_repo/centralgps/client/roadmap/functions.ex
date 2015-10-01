defmodule CentralGPS.Repo.Client.Roadmap.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Client.Roadmap.Commands
  require Logger

  def fn_api_roadmap_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
