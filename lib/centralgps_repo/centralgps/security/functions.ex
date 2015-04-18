defmodule CentralGPS.Repo.Security.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Security.Commands
  require Logger

  def fn_login(params, filter_keys \\ []) do
    query(cmd_fn_login, params, filter_keys)
  end

  def fn_create_login_account(params, filter_keys \\ []) do
    query(cmd_fn_login, params, filter_keys)
  end

end
