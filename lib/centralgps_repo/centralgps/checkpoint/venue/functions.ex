defmodule CentralGPS.Repo.Checkpoint.Venue.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Venue.Commands
  require Logger

  def fn_api_venue_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
