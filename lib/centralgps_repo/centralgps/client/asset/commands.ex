defmodule CentralGPS.Repo.Client.Asset.Commands do

  def cmd_fn_api_client_asset_list,
    do: "SELECT * FROM client.fn_api_client_asset_list($1, $2::bigint, $3::bigint);"

end
