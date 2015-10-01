defmodule CentralGPS.Repo.Checkpoint.Venue.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Venue.Commands
  require Logger

  def fn_api_venue_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
