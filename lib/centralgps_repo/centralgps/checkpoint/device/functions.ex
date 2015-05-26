defmodule CentralGPS.Repo.Checkpoint.Device.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Device.Commands
  require Logger

  def fn_chkapi_device_register(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_device_register, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_action_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_action_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_reason_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_reason_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_venue_type_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_venue_type_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_venue_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_venue_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_near_venue_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_near_venue_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_register_position(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_register_position, _params, filter_keys)
    {row_count, hd(result)}
  end

end
