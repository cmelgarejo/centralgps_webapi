defmodule CentralGPS.Repo.Checkpoint.Device.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Device.Commands
  require Logger

  def fn_chkapi_device_register(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_device_register, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_record(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_record, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_venue_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_venue_create, params, filter_keys)
    {row_count, hd(result)}
  end

  #Lists
  def fn_chkapi_activity_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_activity_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_form_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_form_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_form_template_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_form_template_list, params, filter_keys)
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

  def fn_chkapi_item_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_item_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_measure_unit_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_measure_item_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_client_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_client_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_chkapi_client_contact_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_client_contact_list, params, filter_keys)
    {row_count, hd(result)}
  end

  #Not implemented
  def fn_chkapi_near_venue_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_chkapi_near_venue_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
