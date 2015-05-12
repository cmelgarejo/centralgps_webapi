defmodule CentralGPS.Repo.Checkpoint.VenueType.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.VenueType.Commands
  require Logger

  def fn_api_venue_type_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_type_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_type_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_type_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_type_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_type_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_type_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_type_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_venue_type_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_venue_type_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
