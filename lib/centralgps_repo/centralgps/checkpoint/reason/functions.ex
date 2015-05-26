defmodule CentralGPS.Repo.Checkpoint.Reason.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Reason.Commands
  require Logger

  def fn_api_reason_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_reason_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_reason_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
