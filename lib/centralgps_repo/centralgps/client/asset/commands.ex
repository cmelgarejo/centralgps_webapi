defmodule CentralGPS.Repo.Client.Asset.Commands do

  def cmd_fn_api_monitor_asset_list,
    do: "SELECT * FROM client.fn_api_monitor_asset_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

end
