defmodule CentralGPS.Repo.Checkpoint.ClientContact.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.ClientContact.Commands
  require Logger

  def fn_api_client_contact_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
