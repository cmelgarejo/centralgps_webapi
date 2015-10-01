defmodule CentralGPS.Repo.Checkpoint.Mark.Functions do
  import CentralGPS.Repo
  import CentralGPS.Repo.Checkpoint.Mark.Commands
  require Logger

  def fn_api_monitor_mark_list(params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_monitor_mark_list, params, filter_keys)
    {row_count, hd(result)}
  end

end
