defmodule CentralGPS.Repo.Security.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Security.Commands
  require Logger

  def fn_api_login(params, filter_keys \\ []) do
    query(cmd_fn_api_login, params, filter_keys)
  end

  def fn_api_account_active(params, filter_keys \\ []) do
    query(cmd_fn_api_account_active, params, filter_keys)
  end

  def fn_api_account_create(params, filter_keys \\ []) do
    query(cmd_fn_api_account_create, params, filter_keys)
  end

  def fn_api_account_read(params, filter_keys \\ []) do
    query(cmd_fn_api_account_read, params, filter_keys)
  end

  def fn_api_account_update(params, filter_keys \\ []) do
    query(cmd_fn_api_account_update, params, filter_keys)
  end

  def fn_api_account_delete(params, filter_keys \\ []) do
    query(cmd_fn_api_account_delete, params, filter_keys)
  end

  #TODO: Test the commented lines.
  def fn_api_account_list(params, filter_keys \\ []) do
    query(cmd_fn_api_account_list, params, filter_keys)
    #{row_count, result} = query(cmd_fn_api_account_list, params, filter_keys)
    #{row_count, hd(result)}
  end

end
