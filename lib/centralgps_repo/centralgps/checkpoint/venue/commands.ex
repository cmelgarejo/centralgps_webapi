defmodule CentralGPS.Repo.Checkpoint.Venue.Commands do
  #DB Definition: checkpoint.fn_api_venue_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_configuration_id, venue_venue_type_id, venue_name, venue_code, venue_description, venue_venue_image, venue_lat, venue_lon, venue_detection_radius, venue_xtra_info) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_venue_create,
    do: "SELECT * FROM checkpoint.fn_api_venue_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: checkpoint.fn_api_venue_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON:[ "venue_type_id", "account_type"]
  def cmd_fn_api_venue_read,
    do: "SELECT * FROM checkpoint.fn_api_venue_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id, venue_type_description, venue_type_image) RETURNS common.return_type_generic
  #Input JSON: [ :venue_type_id, venue_type_description, venue_type_image]
  def cmd_fn_api_venue_update,
    do: "SELECT * FROM checkpoint.fn_api_venue_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: checkpoint.fn_api_venue_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON: [ "venue_type_id" ]
  def cmd_fn_api_venue_delete,
    do: "SELECT * FROM checkpoint.fn_api_venue_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_type" ]
  def cmd_fn_api_venue_list,
    do: "SELECT * FROM checkpoint.fn_api_venue_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

end
