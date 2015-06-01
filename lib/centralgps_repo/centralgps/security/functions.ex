defmodule CentralGPS.Repo.Security.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Security.Commands
  require Logger

  def fn_api_login(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_login, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_logout(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_logout, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_active(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_active, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_role_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_role_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_role_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_role_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_permission_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_permission_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_permission_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_permission_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_account_permission_check(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_account_permission_check, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_session_token_account_permission_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_session_token_account_permission_list, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_session_token_account_role_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_session_token_account_role_list, _params, filter_keys)
    {row_count, hd(result)}
  end
end
