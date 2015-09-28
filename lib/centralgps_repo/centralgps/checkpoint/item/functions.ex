defmodule CentralGPS.Repo.Checkpoint.Item.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Item.Commands
  require Logger

  def fn_api_item_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
