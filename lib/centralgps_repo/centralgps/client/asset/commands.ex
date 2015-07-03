defmodule CentralGPS.Repo.Client.Asset.Commands do

  def cmd_fn_api_monitor_asset_list,
    do: "SELECT * FROM client.fn_api_monitor_asset_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

  def cmd_fn_api_asset_record_list,
    do: "SELECT * FROM client.fn_api_asset_record_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text, $12::bigint, $13::timestamp, $14::timestamp);"
end
