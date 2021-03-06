defmodule CentralGPS.Repo.Checkpoint.MeasureUnit.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.MeasureUnit.Commands
  require Logger

  def fn_api_measure_unit_create(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_measure_unit_create, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_measure_unit_read(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_measure_unit_read, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_measure_unit_update(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_measure_unit_update, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_measure_unit_delete(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_measure_unit_delete, params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_measure_unit_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_measure_unit_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
