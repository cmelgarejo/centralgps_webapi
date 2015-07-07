defmodule CentralGPS.Repo.Client.Roadmap.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Client.Roadmap.Commands
  require Logger

  def fn_api_roadmap_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
