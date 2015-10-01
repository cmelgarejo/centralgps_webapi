defmodule CentralGPS.Repo.Client.AssetRoadmap.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Client.AssetRoadmap.Commands
  require Logger

  def fn_api_asset_roadmap_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_roadmap_all_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_roadmap_all_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
