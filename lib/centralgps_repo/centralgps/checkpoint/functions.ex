defmodule CentralGPS.Repo.Checkpoint.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Commands
  require Logger

  def fn_register_device(params, filter_keys \\ []) do
    query(cmd_fn_register_device, params, filter_keys)
  end

  def fn_get_actions_by_auth_token(params, filter_keys \\ []) do
    query(cmd_fn_get_actions_by_auth_token, params, filter_keys)
  end

  def fn_get_reasons_by_auth_token(params, filter_keys \\ []) do
    query(cmd_fn_get_reasons_by_auth_token, params, filter_keys)
  end

  def fn_get_venue_types_by_auth_token(params, filter_keys \\ []) do
    query(cmd_fn_get_venue_types_by_auth_token, params, filter_keys)
  end

  def fn_get_all_venues_by_auth_token(params, filter_keys \\ []) do
    query(cmd_fn_get_all_venues_by_auth_token, params, filter_keys)
  end

  def fn_get_near_venues_by_auth_token(params, filter_keys \\ []) do
    query(cmd_fn_get_near_venues_by_auth_token, params, filter_keys)
  end

  def fn_register_position(params, filter_keys \\ []) do
    query(cmd_fn_register_position, params, filter_keys)
  end

end
