defmodule CentralGPS.Repo.Checkpoint.VenueType.Commands do
  #DB Definition: checkpoint.fn_api_venue_type_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_configuration_id, venue_type_description, venue_type_image) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_venue_type_create,
    do: "SELECT * FROM checkpoint.fn_api_venue_type_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: checkpoint.fn_api_venue_type_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON:[ "venue_type_id", "account_type"]
  def cmd_fn_api_venue_type_read,
    do: "SELECT * FROM checkpoint.fn_api_venue_type_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_type_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id, venue_type_description, venue_type_image) RETURNS common.return_type_generic
  #Input JSON: [ :venue_type_id, venue_type_description, venue_type_image]
  def cmd_fn_api_venue_type_update,
    do: "SELECT * FROM checkpoint.fn_api_venue_type_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: checkpoint.fn_api_venue_type_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON: [ "venue_type_id" ]
  def cmd_fn_api_venue_type_delete,
    do: "SELECT * FROM checkpoint.fn_api_venue_type_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_type_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_type" ]
  def cmd_fn_api_venue_type_list,
    do: "SELECT * FROM checkpoint.fn_api_venue_type_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text);"

end
