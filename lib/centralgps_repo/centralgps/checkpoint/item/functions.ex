defmodule CentralGPS.Repo.Checkpoint.Item.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Item.Commands
  require Logger

  def fn_api_item_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_item_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_item_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
