defmodule CentralGPS.Repo.Checkpoint.Form.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Form.Commands
  require Logger

  def fn_api_form_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
