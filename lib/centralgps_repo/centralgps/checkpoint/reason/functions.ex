defmodule CentralGPS.Repo.Checkpoint.Reason.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Reason.Commands
  require Logger

  def fn_api_reason_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
