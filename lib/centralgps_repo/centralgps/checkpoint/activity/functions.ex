defmodule CentralGPS.Repo.Checkpoint.Activity.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Activity.Commands
  require Logger

  def fn_api_activity_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_activity_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_activity_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_activity_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_activity_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_activity_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_activity_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_activity_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_activity_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_activity_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
