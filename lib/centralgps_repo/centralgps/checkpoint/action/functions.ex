defmodule CentralGPS.Repo.Checkpoint.Action.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Action.Commands
  require Logger

  def fn_api_action_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_action_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_action_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_action_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_action_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_action_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_action_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_action_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_action_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_action_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
