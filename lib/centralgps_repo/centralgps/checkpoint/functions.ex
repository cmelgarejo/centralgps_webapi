defmodule CentralGPS.Repo.Checkpoint.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Commands
  require Logger

  def fn_chkapi_device_register(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_device_register, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_action_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_action_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_reason_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_reason_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_venue_type_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_venue_type_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_venue_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_venue_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_near_venue_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_near_venue_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_register_position(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_register_position, params, filter_keys)
    {row_count, hd(result)}
  end

end
