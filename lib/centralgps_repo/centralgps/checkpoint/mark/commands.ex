defmodule CentralGPS.Repo.Checkpoint.Mark.Commands do
  def cmd_fn_api_monitor_mark_list,
    do: "SELECT * FROM checkpoint.fn_api_monitor_mark_list($1, $2, $3, $4, $5::jsonb, $9::bigint, $10::bigint, $11::text, $12::text, $6::bigint, $7::timestamp, $8::timestamp);"
end
