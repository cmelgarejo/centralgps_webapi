defmodule CentralGPS.Repo.Checkpoint.Client.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Client.Commands
  require Logger

  def fn_api_client_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
