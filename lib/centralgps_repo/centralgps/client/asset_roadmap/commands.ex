defmodule CentralGPS.Repo.Client.AssetRoadmap.Commands do
  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_create,
    do: "SELECT * FROM client.fn_api_asset_roadmap_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10::boolean);"

  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_read,
    do: "SELECT * FROM client.fn_api_asset_roadmap_read($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_update,
    do: "SELECT * FROM client.fn_api_asset_roadmap_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10::boolean);"

  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_delete,
    do: "SELECT * FROM client.fn_api_asset_roadmap_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_list,
    do: "SELECT * FROM client.fn_api_asset_roadmap_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text, $12::bigint);"

  #DB Definition:
  #Input JSON:
  def cmd_fn_api_asset_roadmap_all_list,
    do: "SELECT * FROM client.fn_api_asset_roadmap_list_all($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
