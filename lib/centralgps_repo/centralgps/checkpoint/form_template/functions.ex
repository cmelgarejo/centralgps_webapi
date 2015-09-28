defmodule CentralGPS.Repo.Checkpoint.FormTemplate.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.FormTemplate.Commands
  require Logger

  def fn_api_form_template_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_template_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_template_read(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_template_read, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_template_update(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_template_update, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_template_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_template_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_form_template_list(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_form_template_list, _params, filter_keys)
    {row_count, hd(result)}
  end

end
