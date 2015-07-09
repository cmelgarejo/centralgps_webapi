defmodule CentralGPS.Repo.Client.RoadmapPoint.Functions do
  import CentralGPS.Repo
    import CentralGPS.Repo.Client.RoadmapPoint.Commands
  require Logger

  def fn_api_roadmap_point_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_point_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_point_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_point_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_point_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end