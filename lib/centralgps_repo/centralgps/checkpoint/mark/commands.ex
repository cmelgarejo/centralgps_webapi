defmodule CentralGPS.Repo.Checkpoint.Mark.Commands do
  def cmd_fn_api_monitor_mark_list,
    do: "SELECT * FROM checkpoint.fn_api_monitor_mark_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::bigint, $11::timestamp, $12::timestamp);"
end
