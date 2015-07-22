defmodule CentralGPS.Repo.Client.AssetRoadmap.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Client.AssetRoadmap.Commands
  require Logger

  def fn_api_asset_roadmap_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
