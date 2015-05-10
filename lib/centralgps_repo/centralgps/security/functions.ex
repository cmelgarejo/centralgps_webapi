defmodule CentralGPS.Repo.Security.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Security.Commands
  require Logger

  def fn_api_login(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_login, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_active(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_active, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_list, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_role_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_role_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_role_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_role_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_permission_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_permission_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_permission_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_permission_delete, params, filter_keys)
    {row_count, hd(result)}
  end

end
