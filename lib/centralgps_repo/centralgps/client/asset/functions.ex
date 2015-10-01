defmodule CentralGPS.Repo.Client.Asset.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Client.Asset.Commands
  require Logger

  def fn_api_monitor_asset_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_monitor_asset_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_asset_record_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_asset_record_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_monitor_asset_roadmap_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_monitor_asset_roadmap_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
