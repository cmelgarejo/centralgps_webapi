defmodule CentralGPS.Repo.Checkpoint.ClientContact.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.ClientContact.Commands
  require Logger

  def fn_api_client_contact_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_client_contact_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_client_contact_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
