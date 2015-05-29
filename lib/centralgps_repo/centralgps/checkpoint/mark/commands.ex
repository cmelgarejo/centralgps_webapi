defmodule CentralGPS.Repo.Checkpoint.Mark.Commands do
  def cmd_fn_api_monitor_mark_list,
    do: "SELECT * FROM client.fn_api_monitor_mark_list($1, $2, $3, $4, $5::jsonb, $6::timestamp, $7::timestamp, $8::bigint, $9::bigint);"
end
