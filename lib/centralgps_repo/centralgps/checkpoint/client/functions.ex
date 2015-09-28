defmodule CentralGPS.Repo.Checkpoint.Client.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Client.Commands
  require Logger

  def fn_api_client_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
